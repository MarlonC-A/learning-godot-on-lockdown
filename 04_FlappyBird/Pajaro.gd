extends KinematicBody2D

export var gravedad = 10;
export var fuerzaSalto = 300;
export var vTerminal = 200;

var salto = false;
var velocidad = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	salto = int(Input.is_action_just_pressed("saltar"));
	var nuevaVelocidad = velocidad + gravedad - fuerzaSalto*salto;
	velocidad = clamp(nuevaVelocidad, vTerminal*-1, vTerminal);
	position.y += velocidad*delta;
	set_rotation_degrees(velocidad*60/200);
