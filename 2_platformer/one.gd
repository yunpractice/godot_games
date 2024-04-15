extends RigidBody2D

@export var hp:int = 3
@export var attack:int = 1
var dead:bool = false

signal hitplayer

var targetpos = Vector2(0,0)
var oripos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(100)
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


func body_shape_entered():
	print("hahahaha")
	pass


func _on_area_2d_area_entered(area):
	if hp > 0:
		hp = hp - 1
	if hp <=0:
		dead = true
	print("be hit, hp:%d" % hp)
	(get_node("AnimationPlayer") as AnimationPlayer).play("be_attack")
	if dead:
		queue_free()
	pass # Replace with function body.
