extends Node

var character_textures = {
	"char-1": "res://assets/characters/anak10tahun.png",
	"char-2": "res://assets/characters/poorman.png",
	"char-3": "res://assets/characters/richman1.png",
	"char-4": "res://assets/characters/anak1.png",
}

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

func set_content(currentDialogue):
	$DialoguePanel/DialogContentScrollContainer/VBoxContainer/DialogueContent.text = currentDialogue["content"]

func set_character_name(currentDialogue):
	$DialoguePanel/DialogContentScrollContainer/VBoxContainer/CharacterName.text = ""
	$DialoguePanel/DialogContentScrollContainer/VBoxContainer/CharacterName.text = find_arr_of_dict(characters, "id", currentDialogue["character"])["name"] if currentDialogue["name"] else ""

func set_character_image(currentDialogue):
	if !currentDialogue["character"]:
		return
	
	var cur_character_texture = character_textures[currentDialogue["character"]] if currentDialogue["character"] else ""
	$DialogueBackground/TextureRect.texture = load(cur_character_texture)
	

func _ready():
	var currentDialogue = find_arr_of_dict(dialogues, "id", Global.current_dialogue)
	
	set_content(currentDialogue)
	set_character_name(currentDialogue)
	set_character_image(currentDialogue)
		
	var choiceButton = load("res://sprites/ChoiceButton.tscn").instance()
	choiceButton.text = "Next"
	choiceButton.goto = currentDialogue["next-dialogue-id"]
	$DialoguePanel/ChoicesScrollContainer/VBoxContainer.add_child(choiceButton)
