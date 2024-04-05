extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var vec=Vector2.ZERO#初速度
const max_speed=5#最大速度值
const accerlate=1#加速度
const fiction=1000#摩擦力系数
func _physics_process(delta):#物理引擎更新的时候使用
	var vec_input=Vector2.ZERO
	vec_input.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	vec_input.y=0 #Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	vec_input=vec_input.normalized()
	if vec_input!=Vector2.ZERO:
		vec=vec.move_toward(vec_input*max_speed,accerlate)#将加速度与速度结合在一起
		if vec_input.x > 0:
			(get_node("Sprite2D2") as Sprite2D).flip_h = false
			
		if vec_input.x < 0:
			(get_node("Sprite2D2") as Sprite2D).flip_h = true
		(get_node("AnimationPlayer") as AnimationPlayer).play("walk")
	else:
		vec=vec.move_toward(Vector2.ZERO,fiction)#添加摩擦
	#建议添加clamped()
	move_and_collide(vec)

func _input(event):
	if event is InputEventJoypadButton and event.is_pressed:
		if event.button_index ==0:
		#print(event.button_index)
			apply_central_impulse(Vector2(0, -300))  # 向上的脉冲来模拟跳跃
			print("hahaha")

func move_left():
	pass
	
func move_right():
	set_axis_velocity(Vector2(100,0))
	pass
