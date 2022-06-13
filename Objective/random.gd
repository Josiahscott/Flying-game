extends Spatial

var number
var x
var y
var z

func _ready():
	randomize()
	number = int(randi() % 10)
	print(number)
	
	global_transform.origin = Vector3(randi() % 10000, randi() % 10000, randi() % 10000)
