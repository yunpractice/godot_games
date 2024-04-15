extends Camera2D

# 镜头跟随的目标对象
@export var target_node_path:NodePath = NodePath();
var follow_target1 = null

@export var ui_node_path:NodePath = NodePath();
var uinode = null

# 偏移量，用于调整镜头相对于目标的位置
var offset1 = -50

func _ready():
	follow_target1 = get_node(target_node_path)
	
	uinode = get_node(ui_node_path)
	#offset1 = follow_target1.position - self.position
	# 可选：设置镜头的初始位置
	self.position.x = follow_target1.position.x + offset1

func _process(delta):
	# 更新镜头位置，使其跟随目标对象
	var x = follow_target1.position.x
	if x < 650 and x > 30:
		self.position.x = follow_target1.position.x + offset1
