extends Node2D

var socket_connect_cursor_res = load("res://textures/socket_connect_cursor.png")

func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(socket_connect_cursor_res)

func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(null)
