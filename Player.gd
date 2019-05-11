extends Area2D

signal hit

export var speed = 400
var screen_size
var velocity : Vector2


func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):

	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	
	#Update sprite accordingly with movement
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
	#Reset vector velocity
	velocity = velocity * 0
	#print("Player velocity = ",  velocity) 
	#print("Player position = ",  position)

#Restart position and collider after death
func start(pos):
	show()
	$CollisionShape2D.disabled = false;

#Signal "hit" handler
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.call_deferred("disabled", true)
