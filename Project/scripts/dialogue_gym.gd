extends Node2D

var debug_dialogue = load("res://dialogues/debug_select_puzzle.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(debug_dialogue, "start")
	DialogueManager.got_dialogue.connect(on_got_dialogue)
	pass

func on_got_dialogue(dialogue_line: DialogueLine) -> void:
	var next_dialogue = null
	if dialogue_line.text.contains("__"):
		next_dialogue = load("res://dialogues/puzzle_" + dialogue_line.text + ".dialogue")
	if next_dialogue:
		DialogueManager.show_dialogue_balloon(next_dialogue, "start")
