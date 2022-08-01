extends KinematicBody

export (NodePath) var patrol_path
var patrolPoints
var patrolIndex = 0

var moveSpeed = 10
var tempSpeed = moveSpeed;
var remainingSpeed = moveSpeed;

var _velocidad = Vector3.ZERO;
var _velocidadHorizontal = Vector2.ZERO

var posicion2D = Vector2.ZERO;

var objetivo = Vector3.ZERO;
var objetivo2D = Vector2.ZERO;
var vectorObjetivo = Vector2.ZERO;
var dirObjetivo = Vector2.ZERO;
var distObjetivo = 0;

var thresholdDistancia = 1;
var sigueAvanzando = true;

func _ready():
	if patrol_path:
		patrolPoints = get_node(patrol_path).curve.get_baked_points()


func _physics_process(delta):
	
	#if !patrol_path or !(patrolIndex < patrolPoints.size() - 1):
	#	return;
	sigueAvanzando = true
	remainingSpeed = moveSpeed;
	
	while sigueAvanzando:
	
		objetivo = patrolPoints[patrolIndex];
		posicion2D = Vector2(translation.x,translation.z);
		objetivo2D = Vector2(objetivo.x,objetivo.z);
		distObjetivo = (posicion2D - objetivo2D).length();
		
		if distObjetivo < thresholdDistancia:
			patrolIndex = wrapi(patrolIndex + 1, 0, patrolPoints.size() - 2);
			objetivo = patrolPoints[patrolIndex];
			objetivo2D = Vector2(objetivo.x,objetivo.z);
		
		vectorObjetivo = (objetivo2D - posicion2D);
		dirObjetivo = vectorObjetivo.normalized();
		distObjetivo = vectorObjetivo.length();
		
		var overshoot = remainingSpeed * delta > distObjetivo;
		
		if overshoot:
			tempSpeed = distObjetivo / delta;
			_velocidadHorizontal = dirObjetivo * tempSpeed;
			remainingSpeed -= tempSpeed;
		else:
			_velocidadHorizontal = dirObjetivo * remainingSpeed;
			sigueAvanzando = false;
		
		_velocidad.x = _velocidadHorizontal.x;
		_velocidad.z = _velocidadHorizontal.y;
		
		_velocidad = move_and_slide(_velocidad);


#func _process(delta):
#	pass
