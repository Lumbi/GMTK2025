extends Node2D

@onready var color_rect:ColorRect = $CanvasLayer2/ColorRect
@onready var tween := create_tween()

var target_material :ShaderMaterial

func _ready() -> void:
	target_material = color_rect.material as ShaderMaterial
	target_material.set_shader_parameter("fade",0)
	fadeIn(2)

func fadeOut():
	tween.tween_method(set_fade_value,1.,0.,.5)
	
func set_fade_value(value: float):
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	target_material.set_shader_parameter("fade", value);

func fadeIn(duration):
	tween.tween_method(set_fade_value,0.,1.,duration)
