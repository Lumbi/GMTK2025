extends Node

func quit():
	get_tree().quit()

func _on_exit_button_pressed() -> void:
	quit()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		quit()

func _on_play_button_pressed() -> void:
	GlobalAudio.play_sfx("TvOn_crt")
	Global.go_to_level("desk")

func _on_fullscreen_button_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		%ScreenButton.text = "Window"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		%ScreenButton.text = "Fullscreen"
