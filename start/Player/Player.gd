extends KinematicBody2D

const GRAVITY: = 900.0
const ACCELERATION: = 2000
const FALL_SPEED: = 500.0
const SPEED: = 500.0
const JUMP_SPEED: = 500.0

var velocity: = Vector2.ZERO
var input_direction: = Vector2.ZERO


func _process(delta: float) -> void:
	input_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_direction.y = int(Input.is_action_just_pressed("jump"))

	if input_direction.x < 0:
		$AnimatedSprite.flip_h = true
	elif input_direction.x > 0:
		$AnimatedSprite.flip_h = false

	if input_direction.x:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")

	if not is_on_floor():
		$AnimatedSprite.play("jump")


func _physics_process(delta: float) -> void:
	var targetvelocity: = Vector2.ZERO
	targetvelocity.x = SPEED * input_direction.x
	targetvelocity.y = FALL_SPEED

	if is_on_floor() and input_direction.y:
		velocity.y = -JUMP_SPEED
		targetvelocity.y = JUMP_SPEED

	velocity.x = move_toward(velocity.x, targetvelocity.x, ACCELERATION * delta)
	velocity.y = move_toward(velocity.y, targetvelocity.y, GRAVITY * delta)

	velocity = move_and_slide(velocity, Vector2.UP)
	pass
