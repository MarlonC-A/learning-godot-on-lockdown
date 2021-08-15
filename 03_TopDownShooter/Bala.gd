extends Area2D


export (int) var rapidez = 5;


var direccion := Vector2.ZERO


func _physics_process(delta: float) -> void:
	if (direccion != Vector2.ZERO):
		var velocidad = direccion * rapidez;
		
		global_position += velocidad;

func darDireccion(nuevaDir: Vector2):
	self.direccion = nuevaDir;
	rotation += nuevaDir.angle();


func _on_DestruirProyectil_timeout():
	queue_free();
