extends KinematicBody2D


export (int) var velocidad = 300;

func _ready():
	pass


func _process(delta):
	var direccionMov := Vector2.ZERO;
	direccionMov.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"));
	direccionMov.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"));
	direccionMov = direccionMov.normalized();
	move_and_slide(direccionMov * velocidad);
	
	look_at(get_global_mouse_position());
