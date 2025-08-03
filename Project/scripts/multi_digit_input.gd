extends Control

var value: int

var digit_nodes = []

func _ready():
	var digits_container = %DigitContainer
	digit_nodes = digits_container.get_children()
	digit_nodes.reverse()
	pass

func _process(_delta: float) -> void:
	var new_value: int = 0
	for n in digit_nodes.size():
		new_value += (digit_nodes[n].get_value() * (pow(10, n)))
	
	# DEBUG and sound
	if value != new_value:
		print("INPUT ", self, " = ", new_value)
		GlobalAudio.play_sfx("2025_GMTL_sfx_date_panel")

	value = new_value
	pass

func get_value() -> int:
	return value
