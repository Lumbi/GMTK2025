extends Button

@export var magnify_cursor: Texture2D = preload("res://textures/cursor_magnify.png") 

var starting_size: Vector2

func on_mouse_hover_enter():
	Input.set_custom_mouse_cursor(magnify_cursor)
	pass
	
func on_mouse_hover_exit():
	Input.set_custom_mouse_cursor(null)
	pass

func _ready() -> void:
	starting_size = size
	mouse_entered.connect(on_mouse_hover_enter)
	mouse_exited.connect(on_mouse_hover_exit)

func set_active(flag):
	if flag:
		size = starting_size
		pass
	else:
		size = Vector2(0, 0)
		pass
