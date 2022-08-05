extends Control
 

func _process(delta):
	if Input.is_action_pressed("esc"): #exits the game
		get_tree().quit()

func _on_Play_pressed():
	print("PLAY")
	get_tree().change_scene("res://World.tscn") #change scene to world scene

func _on_Exit_pressed():
	get_tree().quit() #exits the game

func _on_Menu_pressed():
	get_tree().change_scene("res://Title + loading screen/Controls.tscn")
