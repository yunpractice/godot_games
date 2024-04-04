extends RigidBody2D

var firstx = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	firstx = position.x
	#set_contact_monitor(true)
	set_axis_velocity(Vector2(-100,0))
	pass # Replace with function body.

func _integrate_forces(state):
	var xform = state.transform
	if xform.origin.x < 0:
		xform.origin.x = firstx
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x < -50:
		queue_free()
	
	pass
