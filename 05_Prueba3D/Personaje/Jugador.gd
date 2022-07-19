extends KinematicBody

export var rapidez: float = 7;
export var fuerza_salto: float = 20;
export var gravedad: float = 50;

var _velocidad := Vector3.ZERO;
var _vectorSnap := Vector3.DOWN;

onready var _brazoResorte: SpringArm = $SpringArm;
onready var _modelo: Spatial = $ModeloArticulado; 

func _ready():
	pass

func _physics_process(delta):
	var direccionMov := Vector3.ZERO;
	direccionMov.x = Input.get_action_strength("derecha") - Input.get_action_strength("izquierda");
	direccionMov.z = Input.get_action_strength("atras") - Input.get_action_strength("adelante");
	direccionMov = direccionMov.rotated(Vector3.UP, _brazoResorte.rotation.y).normalized();
	
	_velocidad.x = direccionMov.x * rapidez;
	_velocidad.z = direccionMov.z * rapidez;
	
	_velocidad = move_and_slide_with_snap(_velocidad,_vectorSnap,Vector3.UP,true);
	
func _process(delta):
	pass
