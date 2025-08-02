extends Node2D

func _on_day_switchboard_button_pressed() -> void:
	Global.go_to_level("switchboard") # TODO

func _on_month_switchboard_button_pressed() -> void:
	Global.go_to_level("switchboard") # TODO
	
func _on_year_switchboard_button_pressed() -> void:
	Global.go_to_level("switchboard") # TODO

func _on_time_machine_button_pressed() -> void:
	Global.go_to_level("time_input")
