extends KinematicBody

export (NodePath) var patrol_path
var patrolPoints
var puntoObj = 0

var speed = 10;
var moveSpeed = speed;
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

var puntoMaximo = 0;

func _ready():
	if patrol_path:
		patrolPoints = get_node(patrol_path).curve.get_baked_points()
		puntoMaximo = patrolPoints.size() - 1;

func _physics_process(delta):
	
	var direccionMov = Input.get_action_strength("adelante") - Input.get_action_strength("atras");
	moveSpeed = speed * direccionMov;
	
	#if !patrol_path or !(puntoObj < patrolPoints.size() - 1):
	#	return;
	sigueAvanzando = true
	remainingSpeed = moveSpeed;
	
	while sigueAvanzando:
	
		objetivo = patrolPoints[puntoObj];
		posicion2D = Vector2(translation.x,translation.z);
		objetivo2D = Vector2(objetivo.x,objetivo.z);
		distObjetivo = (objetivo2D - posicion2D).length();
		
		if distObjetivo < thresholdDistancia:
			puntoObj = clamp(puntoObj + sign(direccionMov), 0, puntoMaximo);
			objetivo = patrolPoints[puntoObj];
			objetivo2D = Vector2(objetivo.x,objetivo.z);
			
			if (distObjetivo <= thresholdDistancia/10) and (puntoObj == 0 or puntoObj == puntoMaximo):
				sigueAvanzando = false;
			
		vectorObjetivo = (objetivo2D - posicion2D);
		dirObjetivo = vectorObjetivo.normalized();
		distObjetivo = vectorObjetivo.length();
		
		var overshoot = abs(remainingSpeed * delta) > distObjetivo;
		
		if overshoot:
			tempSpeed = distObjetivo / delta;
			_velocidadHorizontal = dirObjetivo * abs(tempSpeed);
			remainingSpeed -= tempSpeed * sign(moveSpeed);
		else:
			_velocidadHorizontal = dirObjetivo * abs(remainingSpeed);
			sigueAvanzando = false;
		
		_velocidad.x = _velocidadHorizontal.x;
		_velocidad.z = _velocidadHorizontal.y;
		
		_velocidad = move_and_slide(_velocidad);


#func _process(delta):
#	pass
