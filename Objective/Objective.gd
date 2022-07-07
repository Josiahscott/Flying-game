extends Spatial

onready var objectives = get_tree().get_nodes_in_group("Objective")
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var new_obj = player.connect("new_location", self, "change_location")

func _ready():
	global_transform.origin = Vector3(1000,1000,1000) #change this to main airport when ready

func change_location():
	pass
#	global_transform.origin = #call random location from group and get its location
