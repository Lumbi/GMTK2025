extends Button

var starting_size: Vector2

func _ready() -> void:
	starting_size = size

func set_active(flag):
	if flag:
		size = starting_size
		pass
	else:
		size = Vector2(0, 0)
		pass
