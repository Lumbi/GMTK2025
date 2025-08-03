extends Node2D

@onready var fade = %Fade

var fade_time = 0
const fade_duration = 3.0

func _process(_delta: float) -> void:
	if fade_time < fade_duration:
		fade_time += _delta
		var alpha = 1.0 - clamp(fade_time / fade_duration, 0 , 1)
		fade.color = Color(0, 0, 0, alpha)
	pass
