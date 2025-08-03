extends Node2D

@onready var fade = %Fade

var fade_time = 0
const fade_duration = 4.0

func _ready():
	fade.visible = true
	%CloseButton.visible = false

func _process(_delta: float) -> void:
	if fade_time < fade_duration:
		fade_time += _delta
		var alpha = 1.0 - clamp(fade_time / fade_duration, 0 , 1)
		fade.color = Color(0, 0, 0, alpha)
		if fade_time >= fade_duration:
			%CloseButton.visible = true
	pass


func _on_close_button_pressed() -> void:
	get_tree().quit()
