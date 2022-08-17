extends Control
 
func _process(delta):
	if Input.is_action_pressed("esc"): #exits the game
		get_tree().quit()

func _on_Exit_pressed():
	get_tree().quit() #exits the game
