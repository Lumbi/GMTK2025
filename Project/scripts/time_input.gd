extends Control

# TODO SET THE RIGHT VALUES!!
var answer_year = 1955
var answer_month = 09
var answer_day = 03

func _on_confirm_button_pressed() -> void:
	var input_year = %YearInput.get_value()
	var input_month = %MonthInput.get_value()
	var input_day = %DayInput.get_value()

	if input_year == answer_year and input_month == answer_month and input_day == answer_day:
		print("YOU WIN!")
		Global.win_game()
	else:
		print("NOPE")
		shake(0.5, 10)
	pass

var original_position := Vector2.ZERO
var shake_time := 0.0
var shake_duration := 0.0
var shake_intensity := 0

func _ready():
	original_position = position

func shake(duration: float, intensity: float) -> void:
	shake_duration = duration
	shake_intensity = intensity
	shake_time = 0.0

func _process(delta: float) -> void:
	if shake_time < shake_duration:
		shake_time += delta
		var offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		position = original_position + offset
	else:
		position = original_position
