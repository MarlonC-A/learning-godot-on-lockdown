extends KinematicBody

export var rapidez: float = 7;
export var fuerza_salto: float = 20;
export var gravedad: float = 50;

var _velocidad := Vector3.ZERO;
var _vectorSnap := Vector3.DOWN;
enum tipoSaltoLista {SaltoVertical,SaltoCorriendo};
var tipoSalto;
var baile: bool;

onready var _brazoResorte: SpringArm = $BrazoResorte;
onready var _modelo: Spatial = $ModeloArticulado; 

var maquinaEstadosAnimacion;

func _ready():
	maquinaEstadosAnimacion = $AnimationTree.get("parameters/playback");

func _physics_process(delta):
	
	baile = true if maquinaEstadosAnimacion.get_current_node() == "Robot_Dance" else false;
	
	var direccionMov := Vector3.ZERO;
	direccionMov.x = Input.get_action_strength("derecha") - Input.get_action_strength("izquierda");
	direccionMov.z = Input.get_action_strength("atras") - Input.get_action_strength("adelante");
	direccionMov = direccionMov.rotated(Vector3.UP, _brazoResorte.rotation.y).normalized();
	
	_velocidad.x = direccionMov.x * rapidez;
	_velocidad.z = direccionMov.z * rapidez;
	_velocidad.y -= gravedad * delta;
	
	var aterrizaje := is_on_floor() and _vectorSnap == Vector3.ZERO;
	var inicioSalto := is_on_floor() and Input.is_action_just_pressed("salto");
	
	if inicioSalto:
		_velocidad.y = fuerza_salto;
		_vectorSnap = Vector3.ZERO;
		
	if aterrizaje:
		_vectorSnap = Vector3.DOWN;
	
	_velocidad *= int(!baile);
	
	_velocidad = move_and_slide_with_snap(_velocidad,_vectorSnap,Vector3.UP,true);
	
	var _velocidadHorizontal := Vector2(_velocidad.x,_velocidad.z);
	
	if inicioSalto:
		if _velocidadHorizontal.length() < 0.5:
			tipoSalto = tipoSaltoLista.SaltoVertical;
		else:
			tipoSalto = tipoSaltoLista.SaltoCorriendo;
	
	if direccionMov.length() > 0.2:
		var anguloViejo = Quat(transform.basis);
		var anguloNuevo = Quat(Vector3(0,1,0),Vector2(direccionMov.z,direccionMov.x).angle());
		var anguloMedio = anguloViejo.slerp(anguloNuevo,0.5);
		transform.basis = Basis(anguloMedio);
		
		if _velocidadHorizontal.length() > 0.5:
			maquinaEstadosAnimacion.travel("Robot_Running");
			
	if _velocidadHorizontal.length() < 0.5:
		if Input.is_action_just_pressed("baile"):
						maquinaEstadosAnimacion.travel("Robot_Dance");
		else:
			maquinaEstadosAnimacion.travel("Robot_Idle");
	
	if !is_on_floor():
		if tipoSalto == tipoSaltoLista.SaltoCorriendo:
			maquinaEstadosAnimacion.travel("Robot_WalkJump");
		else:
			maquinaEstadosAnimacion.travel("Robot_Jump");
	
func _process(delta):
	_brazoResorte.translation = translation;
