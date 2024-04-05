extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_joy_button_pressed(0,JOY_BUTTON_A) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		(get_node("AnimationPlayer") as AnimationPlayer).play("jump")
		
	if Input.is_joy_button_pressed(0,JOY_BUTTON_B) and is_on_floor():
		(get_node("AnimationPlayer") as AnimationPlayer).play("attack")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			(get_node("Sprite2D2") as Sprite2D).flip_h = false
			(get_node("Sprite2D2") as Sprite2D).offset.x = 20
			
		if direction < 0:
			(get_node("Sprite2D2") as Sprite2D).flip_h = true
			(get_node("Sprite2D2") as Sprite2D).offset.x = -20
		(get_node("AnimationPlayer") as AnimationPlayer).play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
