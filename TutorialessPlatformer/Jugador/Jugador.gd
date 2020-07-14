extends KinematicBody2D

var hspd = 100;
var vspd = -200;
var grav = 9.8;
var velocity = Vector2();


func _ready():
	pass;

func _process(delta):
	var rightkey = int(Input.is_key_pressed(KEY_D));
	var leftkey = int(Input.is_key_pressed(KEY_A));
	velocity.x = hspd*(rightkey - leftkey);
	
	var jumpkey = Input.is_key_pressed(KEY_SPACE);
	if(is_on_floor()):
		if(jumpkey):
			velocity.y = vspd;
	else:
		velocity.y += grav;

	velocity = move_and_slide(velocity, Vector2(0, -1));
	position += velocity*delta;
