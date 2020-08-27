extends KinematicBody2D

const UP = Vector2(0, -1)
const ACCELERATION = 50
const MAX_SPEED = 500
const GRAVITY = 100
const JUMP_HEIGHT = -1500

var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("left"):
		velocity.x = max(velocity.x-ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.play("walk_left")
		$AnimatedSprite.flip_h = true
		
	elif Input.is_action_pressed("right"):
		velocity.x = min(velocity.x+ACCELERATION, MAX_SPEED)
		$AnimatedSprite.play("walk_right")
		$AnimatedSprite.flip_h = false
	else: 
		#$AnimatedSprite.play("Idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("up_jump"):
			velocity.y = JUMP_HEIGHT
		if friction == true:
			velocity.x = lerp(velocity.x, 0, 0.2)
	
	else:
		#$AnimatedSprite.play("jump")
		if friction == true:
			velocity.x = lerp(velocity.x, 0, 0.05)
						
	
	velocity = move_and_slide(velocity, UP)
	#velocity vai me retornar a minha própria velocidade e se eu colidir em algo volta a zerar.
	
	
