extends RigidBody

onready var locations = get_tree().get_nodes_in_group("locations")
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var new_obj = player.connect("new_location", self, "change_location")

func _ready():
	randomize()
	global_transform.origin = Vector3(3300,1000,-300)
#	global_transform.origin = Vector3(randi() % 12000, 2000, randi() % 12000)
#	global_transform.origin = locations[randi()%len(locations)].global_transform.origin
#	change_location()
	
func change_location():
#	global_transform.origin = locations[randi()%len(locations)].global_transform.origin
	global_transform.origin = Vector3(randi() % 12000, 2000, randi() % 12000)
