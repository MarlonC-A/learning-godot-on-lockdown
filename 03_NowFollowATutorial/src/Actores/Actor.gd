extends KinematicBody2D
class_name Actor

var velocidad: = Vector2.ZERO

export var gravedad = 3000.0

func _physics_process(delta:float) -> void:
	velocidad.y += gravedad*delta
	velocidad = move_and_slide(velocidad)
