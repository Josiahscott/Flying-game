extends Spatial

var number
var x
var y
var z
onready var new_location = 
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var new_obj = player.connect("new_objective",self,"change_location")

func _ready():
	global_transform.origin = Vector3(1000,1000,1000)
#	global_transform.origin = Vector3(randi() % 10000, randi() % 10000, randi() % 10000)
#	rotation.y = rand_range(-2.5, 2.5 * PI)
#	print(rotation.y)

func change_location():
	global_transform.origin = Vector3(new_location)
#	global_transform.origin = Vector3(randi() % 10000, randi() % 10000, randi() % 10000)
#	rotation.y = rand_range(0, 360)
#	print(rotation.y)
	
#func _physics_process(delta):
#		look_at(player.global_transform.origin,Vector3.UP)
