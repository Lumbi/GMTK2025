extends Node

func quit():
	get_tree().quit()

func _on_exit_button_pressed() -> void:
	quit()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		quit()
