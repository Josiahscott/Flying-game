extends Area
var bodies
var player = null
var interact_text = "Press E to pick up Drink" #text to show up on screen
onready var InventoryUI = get_tree().get_nodes_in_group("InventoryUI")[0]
func _process(delta):
	if player!= null:
		if Input.is_action_just_pressed("use"):
			print("Pick up Drink") #pick up drink
			queue_free()
			InventoryUI.Inventoryitems.append("Water") #adding drink to hotbar
		
func _on_Area_body_entered(body): #Body entering the area of the water
	if body.is_in_group("Player"):
		print("adding player")
		player = body
		

func _on_Area_body_exited(body): #Body leaving the area of the water
	if body.is_in_group("Player"):
		print("player leaving")
		player = null
