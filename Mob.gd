extends RigidBody2D

export var min_speed = 150
export var max_speed = 300

var mob_types = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
