extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(1000)
	connect("body_entered",entered)
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		set_axis_velocity(Vector2(0,-100))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func entered(_body):
	print("hehehe")
	if _body is RigidBody2D:
		print("peng peng")
