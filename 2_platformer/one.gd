extends RigidBody2D

var hp = 3
var targetpos = Vector2(0,0)
var oripos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	oripos = position
	targetpos = oripos + Vector2(randf_range(-200,200),0)
	set_dir()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var dir = -1
	if position.x < targetpos.x:
		dir = 1
	move_and_collide(Vector2(delta*30*dir,0))
	move()

func move():
	if abs(targetpos.x - position.x) < 5:
		targetpos = oripos + Vector2(randf_range(-100,100),0)
		set_dir()
		return

func set_dir():
	if targetpos.x > position.x:
		(get_node("Sprite2D") as Sprite2D).flip_h = true
	else:
		(get_node("Sprite2D") as Sprite2D).flip_h = false
