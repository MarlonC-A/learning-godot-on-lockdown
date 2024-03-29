extends KinematicBody2D


signal balaDisparada(bala, posicion, direccion);


export (PackedScene) var Bala;
export (int) var velocidad = 300;


func _ready():
	pass


onready var puntaPistola = $PuntaPistola;
onready var cooldownAtaque = $CooldownAtaque;
onready var animacionFogonazo = $Fogonazo/AnimationPlayer;

func _process(delta):
	var direccionMov := Vector2.ZERO;
	direccionMov.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"));
	direccionMov.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"));
	direccionMov = direccionMov.normalized();
	move_and_slide(direccionMov * velocidad);
	look_at(get_global_mouse_position());

	if Input.is_action_pressed("dispara"):
		dispara();


#func _unhandled_input(evento):
#	if evento.is_action_pressed("dispara"):
#		dispara();

func dispara():
	if cooldownAtaque.is_stopped():
		var balaInstancia = Bala.instance();
		var dirBala := (get_global_mouse_position() - self.global_position).normalized();
		emit_signal("balaDisparada", balaInstancia, puntaPistola.global_position, dirBala);
		cooldownAtaque.start();
		animacionFogonazo.play("fogonazo");
	else:
		pass;
