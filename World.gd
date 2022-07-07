extends Spatial

func _ready():
	var objectives = get_tree().get_nodes_in_group("Objective")
	for o in objectives:
		print(o.global_transform.origin)
