extends Node2D

@onready var wire = $"Wire"

func _process(delta: float) -> void:
	var mouse_viewport_pos = get_viewport().get_mouse_position()
	# var what = get_global_transform().inverse().basis_xform(mouse_viewport_pos)
	wire.move_end_to(mouse_viewport_pos)
