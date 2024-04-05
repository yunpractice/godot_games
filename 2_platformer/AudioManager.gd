extends Node

var curr = 0
var total = 10
var soundMap = {}

func _ready():
	for i in range(total):
		self.add_child(AudioStreamPlayer.new())
	soundMap["coin"] = load("res://coin.mp3")
	soundMap["attack"] = load("res://attack.wav")
	
func play(name : String):
	var sfx = self.get_child(curr)
	if sfx is AudioStreamPlayer:
		if(soundMap[name]):
			sfx.stream = soundMap[name]
			sfx.play()
			curr = (curr+1)%total
