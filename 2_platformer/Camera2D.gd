extends Camera2D

# 镜头跟随的目标对象
@export var target_node_path:NodePath = NodePath();
var follow_target1 = null

# 偏移量，用于调整镜头相对于目标的位置
var offset1 = Vector2(0, 0)

func _ready():
	follow_target1 = get_node(target_node_path)
	# 可选：设置镜头的初始位置
	self.position = follow_target1.position + offset1

func _process(delta):
	# 更新镜头位置，使其跟随目标对象
	self.position = follow_target1.position + offset1
