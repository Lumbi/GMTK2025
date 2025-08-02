extends Camera2D

# Movement speed in pixels per second
@export var speed: float = 300.0

func _process(delta: float) -> void:
	var input_vector := Vector2.ZERO

	# Capture input
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Normalize to avoid faster diagonal movement
	input_vector = input_vector.normalized()

	# Move the camera
	position += input_vector * speed * delta
