extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("jump"):
		$AnimatedSprite2D.play("jump")
	if is_on_floor() and Input.is_anything_pressed() == false:
		$AnimatedSprite2D.play("idle")

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	if direction == -1:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
	if direction == 1:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		$AnimatedSprite2D.play("attack")
