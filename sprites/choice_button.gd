extends Button

var goto

func _on_ChoiceButton_pressed():
	Global.current_dialogue = goto
	get_tree().change_scene("res://menus/dialogue_menu/dialogue_menu.tscn")
