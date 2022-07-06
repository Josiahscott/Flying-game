extends Spatial

var number
var x
var y
var z

onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var new_obj = player.connect("new_objective",self,"change_location")

func _ready():
	randomize()
	number = int(randi() % 10) 
	print(number) #To call a random variable e.g random airfield instead of random place on map once airfield design is done
	
	global_transform.origin = Vector3(randi() % 10000, randi() % 10000, randi() % 10000)
#	rotation.y = rand_range(-2.5, 2.5 * PI)
#	print(rotation.y)

func change_location():
	global_transform.origin = Vector3(randi() % 10000, randi() % 10000, randi() % 10000)
#	rotation.y = rand_range(0, 360)
#	print(rotation.y)
	
func _physics_process(delta):
		look_at(player.global_transform.origin,Vector3.UP)
