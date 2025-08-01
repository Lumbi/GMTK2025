extends Control

const digit_0 = preload("res://textures/digit_0.png")
const digit_1 = preload("res://textures/digit_1.png")
const digit_2 = preload("res://textures/digit_2.png")
const digit_3 = preload("res://textures/digit_3.png")
const digit_4 = preload("res://textures/digit_4.png")
const digit_5 = preload("res://textures/digit_5.png")
const digit_6 = preload("res://textures/digit_6.png")
const digit_7 = preload("res://textures/digit_7.png")
const digit_8 = preload("res://textures/digit_8.png")
const digit_9 = preload("res://textures/digit_9.png")

var digit: int = 0

func _on_up_pressed() -> void:
	digit = (digit + 1) % 10
	update()

func _on_down_pressed() -> void:
	digit = (digit + 10 - 1) % 10
	update()

func update():
	match digit:
		0: %DigitTexture.texture = digit_0
		1: %DigitTexture.texture = digit_1
		2: %DigitTexture.texture = digit_2
		3: %DigitTexture.texture = digit_3
		4: %DigitTexture.texture = digit_4
		5: %DigitTexture.texture = digit_5
		6: %DigitTexture.texture = digit_6
		7: %DigitTexture.texture = digit_7
		8: %DigitTexture.texture = digit_8
		9: %DigitTexture.texture = digit_9
