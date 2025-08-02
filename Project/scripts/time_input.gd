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
		# do a shake effect of something?

	pass
