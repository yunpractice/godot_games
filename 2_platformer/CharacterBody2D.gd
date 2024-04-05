extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var tile_map:TileMap;

@export var control:Control

var coin = 0

func _ready():
	pass

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
		AudioManager.play("attack")

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
	check_eat()
	
func check_eat():
	if not is_on_floor():
		return

	var xindex = int((position.x) / 32)
	var yindex = int(position.y / 32)+1
	check_cell(xindex,yindex)
	check_cell(xindex,yindex-1)

func check_cell(x,y):
	var data = tile_map.get_cell_tile_data(0,Vector2(x,y))
	if not data:
		return

	if data.get_custom_data("coin") == true:
		tile_map.erase_cell(0,Vector2(x,y))
		coin = coin + 1
		(control.get_node("Label") as Label).text = "coin：" + str(coin)
		AudioManager.play("coin")
		
