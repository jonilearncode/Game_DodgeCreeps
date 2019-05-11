extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$inGame.play()
	$UI.update_score(score)
	$UI.show_message("Get ready!")

func game_over():
	$inGame.stop()
	$gameOver.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$UI.show_game_over()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$UI.update_score(score)

func _on_MobTimer_timeout():
	#Choose a random location on Path2d
	$MobPath/MobSpawnLocation.set_offset(randi())
	print("mob start location: ", $MobPath/MobSpawnLocation.position)
	#Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	#Set the mob's position to a random location
	mob.position = $MobPath/MobSpawnLocation.position
	#Set the mob's direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	#Add some ramdomness to the direction
	direction += rand_range(-PI / 4, PI / 4 )
	mob.rotation = direction
	#Set the velocity (speed & direction)
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

