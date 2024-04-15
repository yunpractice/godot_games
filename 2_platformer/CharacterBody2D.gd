extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var tile_map:TileMap;

@export var control:Control

var coin = 0
var on_ladder = false
var after_ladder = false
var left = false

func _ready():
	pass

func _physics_process(delta):
	var floor = is_on_floor()
	if not on_ladder and floor:
		on_ladder = check_on_ladder(position.x,position.y)
	
	if not floor and on_ladder:
		on_ladder = check_on_ladder(position.x,position.y)
		if not on_ladder:
			after_ladder = true
			velocity.y = 0

	print(on_ladder)
	# Add the gravity.
	if not is_on_floor() and not on_ladder and not after_ladder:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_joy_button_pressed(0,JOY_BUTTON_A) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		(get_node("AnimationPlayer") as AnimationPlayer).play("jump")
		
	if Input.is_joy_button_pressed(0,JOY_BUTTON_B) and is_on_floor():
		if left == true:
			(get_node("AnimationPlayer") as AnimationPlayer).play("attack_left")
		else:
			(get_node("AnimationPlayer") as AnimationPlayer).play("attack")
		AudioManager.play("attack")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		after_ladder = false
		if direction > 0:
			(get_node("Sprite2D2") as Sprite2D).flip_h = false
			
			(get_node("Sprite2D2") as Sprite2D).offset.x = 20
			left = false
			
		if direction < 0:
			(get_node("Sprite2D2") as Sprite2D).flip_h = true
			(get_node("Sprite2D2") as Sprite2D).offset.x = -20
			left = true
		(get_node("AnimationPlayer") as AnimationPlayer).play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var updirection = Input.get_axis("ui_up", "ui_down")
	if on_ladder:
		if updirection:	
			if updirection > 0:
				velocity.y = updirection * SPEED/2
			elif updirection < 0:
				velocity.y = updirection * SPEED/2
		else:
			velocity.y = 0
		
			

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
		
	if data.get_custom_data("bwall") == true:
		tile_map.erase_cell(0,Vector2(x,y))
		coin = coin + 1
		AudioManager.play("coin")
		
func check_on_ladder(posx,posy):
	var x = int((posx) / 32)
	var y = int((posy+15) / 32)+1
	#print("%d %d" %[x,y])
	var data1 = tile_map.get_cell_tile_data(0,Vector2(x,y))
	var data2 = tile_map.get_cell_tile_data(0,Vector2(x,y))
	var data3 = tile_map.get_cell_tile_data(0,Vector2(x,y))

	if not data1:
		return false

	if data1.get_custom_data("ladder") == true:
		return true
	
	return false
