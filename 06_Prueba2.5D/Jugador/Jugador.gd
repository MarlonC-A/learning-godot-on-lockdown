extends KinematicBody

var move_speed = 100
export (NodePath) var patrol_path
var patrolPoints
var patrolIndex = 0
var _velocidadHorizontal = Vector2.ZERO
var _velocidad = Vector3.ZERO;
var posicion2D = Vector2.ZERO;
var punto2D = Vector2.ZERO;
var target = Vector3.ZERO;
var distancia2D = 0;
var thresholdDistancia = 1;


func _ready():
	if patrol_path:
		patrolPoints = get_node(patrol_path).curve.get_baked_points()


func _physics_process(delta):
	
	if !patrol_path or !(patrolIndex < patrolPoints.size() - 1):
		return;
	
	target = patrolPoints[patrolIndex];
	posicion2D = Vector2(translation.x,translation.z);
	punto2D = Vector2(target.x,target.z);
	distancia2D = (posicion2D - punto2D).length();
	
	if distancia2D < thresholdDistancia:
		patrolIndex += 1;
		target = patrolPoints[patrolIndex];
		punto2D = Vector2(target.x,target.z);
	
	var vecToTarget = (punto2D - posicion2D);
	var dirToTarget = vecToTarget.normalized();
	var distToTarget = vecToTarget.length();
	
	var overshoot = move_speed * delta > distToTarget;
	
	if overshoot:
		var tempSpeed = distToTarget / delta;
		_velocidadHorizontal = dirToTarget * tempSpeed;
	else:
		_velocidadHorizontal = dirToTarget * move_speed;
	
	print (_velocidadHorizontal.length());
	
	_velocidad.x = _velocidadHorizontal.x;
	_velocidad.z = _velocidadHorizontal.y;
	
	_velocidad = move_and_slide(_velocidad);


#func _process(delta):
#	pass
