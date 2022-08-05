extends Control
 

func _process(delta):
	if Input.is_action_pressed("esc"): #exits the game
		get_tree().quit()

func _on_Back_pressed():
	get_tree().change_scene("res://Title + loading screen/Title.tscn")
