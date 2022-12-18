extends Node

func read_dialogues_json():
	var f = File.new()
	var open_err = f.open("res://dialogues.json", File.READ)
	var parse_err = JSON.parse(f.get_as_text())
	return parse_err.result

func find_arr_of_dict(arr, key, value):
	for element in arr:
		if element[key] == value:
			return element
			
var dialogues = read_dialogues_json()["dialogues"]
var characters = read_dialogues_json()["characters"]

func _ready():
	var currentDialogue = find_arr_of_dict(dialogues, "id", Global.current_dialogue)
	$DialoguePanel/CharacterName.text = find_arr_of_dict(characters, "id", currentDialogue["character"])["name"]
	$DialoguePanel/DialogueContent.text = currentDialogue["content"]
	
	if currentDialogue["choices"] != null:
		for choice in currentDialogue["choices"]:
			var choiceButton = load("res://sprites/ChoiceButton.tscn").instance()
			choiceButton.text = choice["content"]
			choiceButton.goto = choice["id"]
			$DialoguePanel/ChoicesScrollContainer/VBoxContainer.add_child(choiceButton)
