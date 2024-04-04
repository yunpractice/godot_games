extends Timer

var pipescn = preload("res://pipe.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout",on_timeout)
	addpipe()
	pass # Replace with function body.

func on_timeout():
	addpipe()

func addpipe():
	var pipe = pipescn.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE) as RigidBody2D
	pipe.position.x = 1200
	pipe.position.y = pipe.position.y + randf_range(-100,100)
	add_child(pipe)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
