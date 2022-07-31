extends KinematicBody

var move_speed = 10
export (NodePath) var patrol_path
var patrol_points
var patrolIndex = 0
var velocity = Vector2.ZERO
var posicion2D = Vector2.ZERO;
var punto2D = Vector2.ZERO;
var target = Vector3.ZERO;
var distancia2D = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func _physics_process(delta):
	if !patrol_path or !(patrolIndex < patrol_points.size() - 1):
		return;
	target = patrol_points[patrolIndex];
	posicion2D = Vector2(translation.x,translation.z);
	punto2D = Vector2(target.x,target.z);
	distancia2D = (posicion2D - punto2D).length();
	
	if distancia2D < 1:
		
		patrolIndex = patrolIndex + 1;
		target = patrol_points[patrolIndex];
		
	velocity = (target - translation).normalized() * move_speed
	velocity = move_and_slide(velocity)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
