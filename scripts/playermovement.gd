extends CharacterBody2D

const GRAVITY = 1200
const MOVE_SPEED = 200
const JUMP_FORCE = -400
const DASH_SPEED = 600
const DASH_TIME = 0.2

var is_dashing = false
var dash_timer = 0.0
var dash_direction = Vector2.ZERO
var can_dash = true

func _physics_process(delta):
	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var input_dir = Vector2(input_x, input_y).normalized()

	if is_on_floor():
		can_dash = true

	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	else:
		velocity.y += GRAVITY * delta
		velocity.x = input_x * MOVE_SPEED

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_FORCE

		if Input.is_action_just_pressed("dash") and can_dash:
			is_dashing = true
			dash_timer = DASH_TIME
			dash_direction = input_dir
			if dash_direction == Vector2.ZERO:
				dash_direction = Vector2.RIGHT
			velocity = dash_direction * DASH_SPEED
			can_dash = false

	move_and_slide()
