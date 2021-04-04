extends Area2D
signal hit

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

# Called when the node enters the scene tree for the first time.
# Similar a 'Create' de Game Maker
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Similar a 'Step' de Game Maker
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	var rightkey = int(Input.is_action_pressed("ui_right"));
	var leftkey = int(Input.is_action_pressed("ui_left"));
	velocity.x = rightkey - leftkey;
	
	var upkey = int(Input.is_action_pressed("ui_up"));
	var downkey = int(Input.is_action_pressed("ui_down"));
	velocity.y = downkey - upkey;
	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop();
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Jugador_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
