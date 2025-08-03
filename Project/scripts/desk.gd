extends Node2D

func _ready() -> void:
	start_tutorial()
	
var tutorial_dialogue = load("res://dialogues/tutorial.dialogue")
func start_tutorial():
	DialogueManager.show_dialogue_balloon(tutorial_dialogue, "start")

func _on_day_switchboard_button_pressed() -> void:
	zoom_to(%DayZoomTarget.global_position)
	$DaySwitchboard/Switchboard.activate()
	$MonthSwitchboard/Switchboard.inactive()
	$YearSwitchboard/Switchboard.inactive()
	GlobalAudio.set_zoom_on_board(true)
	pass

func _on_month_switchboard_button_pressed() -> void:
	zoom_to(%MonthZoomTarget.global_position)
	$DaySwitchboard/Switchboard.inactive()
	$MonthSwitchboard/Switchboard.activate()
	$YearSwitchboard/Switchboard.inactive()
	GlobalAudio.set_zoom_on_board(true)
	pass
	
func _on_year_switchboard_button_pressed() -> void:
	zoom_to(%YearZoomTarget.global_position)
	$DaySwitchboard/Switchboard.inactive()
	$MonthSwitchboard/Switchboard.inactive()
	$YearSwitchboard/Switchboard.activate()
	GlobalAudio.set_zoom_on_board(true)
	pass

func _on_input_button_pressed() -> void:
	zoom_to($InputZoomTarget.global_position)
	pass

func _on_back_button_pressed() -> void:
	zoom_back()
	pass

func zoom_to(_position) -> void:
	$Camera2D.zoom_to(0.8, _position)
	%ZoomBackButton.visible = true
	set_click_area_button_active(false)
	pass
	
func zoom_back() -> void:
	$YearSwitchboard/Switchboard.reset()
	$MonthSwitchboard/Switchboard.reset()
	$DaySwitchboard/Switchboard.reset()
	set_click_area_button_active(true)
	$Camera2D.zoom_to(0.4, Vector2(0, 0))
	%ZoomBackButton.visible = false
	GlobalAudio.set_zoom_on_board(false)

func set_click_area_button_active(flag):
	%YearSwitchboardButton.set_active(flag)
	%MonthSwitchboardButton.set_active(flag)
	%DaySwitchboardButton.set_active(flag)
	%InputClickAreaButton.set_active(flag)
