extends SpringArm

export var sensibilidadMouse := 0.3;
var rotacionCamara : Vector2;
var altura = 0;

func _ready():
	set_as_toplevel(true);
	altura = translation.y;

func _process(delta):
	
	rotacionCamara.y += Input.get_action_strength("camaraIzquierda") - Input.get_action_strength("camaraDerecha");
	rotacionCamara.x += Input.get_action_strength("camaraAbajo") - Input.get_action_strength("camaraArriba");
	
	rotacionCamara.x = clamp(rotacionCamara.x,-90,30);
	rotacionCamara.y = wrapf(rotacionCamara.y,0,360);
	
	rotation_degrees.x = rotacionCamara.x;
	rotation_degrees.y = rotacionCamara.y;
	
	translation.y += altura;

func _input(event):
	if event is InputEventMouseMotion:
		rotacionCamara.x -= event.relative.y * sensibilidadMouse;
		rotacionCamara.y -= event.relative.x * sensibilidadMouse;
