extends Node2D

func _on_day_switchboard_button_pressed() -> void:
	zoom_to($DayZoomTarget.global_position)
	pass

func _on_month_switchboard_button_pressed() -> void:
	zoom_to($MonthZoomTarget.global_position)
	pass
	
func _on_year_switchboard_button_pressed() -> void:
	zoom_to($YearZoomTarget.global_position)
	$YearSwitchboard/Switchboard.activate()
	pass

func _on_input_button_pressed() -> void:
	zoom_to($InputZoomTarget.global_position)
	pass

func _on_back_button_pressed() -> void:
	zoom_back()
	pass

func zoom_to(_position) -> void:
	$Camera2D.zoom_to(1.0, _position)
	%ZoomBackButton.visible = true
	pass
	
func zoom_back() -> void:
	$YearSwitchboard/Switchboard.reset()
	
	$Camera2D.zoom_to(0.5, Vector2(0, 0))
	%ZoomBackButton.visible = false
