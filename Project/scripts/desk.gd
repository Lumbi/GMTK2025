extends Node2D

func _on_day_switchboard_button_pressed() -> void:
	$Camera2D.zoom_to(1.0, $DayZoomTarget.global_position)
	pass

func _on_month_switchboard_button_pressed() -> void:
	$Camera2D.zoom_to(1.0, $MonthZoomTarget.global_position)
	pass
	
func _on_year_switchboard_button_pressed() -> void:
	$Camera2D.zoom_to(1.0, $YearZoomTarget.global_position)
	pass

func _on_input_button_pressed() -> void:
	$Camera2D.zoom_to(1.0, $InputZoomTarget.global_position)
	pass

func _on_back_button_pressed() -> void:
	$Camera2D.zoom_to(0.5, Vector2(0, 0))
	pass
