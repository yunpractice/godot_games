extends Sprite2D

var firstx = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	firstx = position.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(-60*delta)
	if position.x < 400: position.x = firstx
	pass
