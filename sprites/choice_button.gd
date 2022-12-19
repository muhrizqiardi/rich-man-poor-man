extends Button

var goto

func _on_ChoiceButton_pressed():
	Global.current_dialogue = goto
	
	if goto == "end":
		get_tree().change_scene("res://menus/tamat_screen/tamat_screen.tscn")
	else:
		get_tree().change_scene("res://menus/dialogue_menu/dialogue_menu.tscn")
