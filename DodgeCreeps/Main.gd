extends Node2D

export (PackedScene) var Enemy
var score

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Jugador.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLoc.set_offset(randi())
	var mob = Enemy.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLoc.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLoc.position
	direction += rand_range(0, PI/2)
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
