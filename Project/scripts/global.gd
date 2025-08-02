extends Node

# This script is automatically loaded globally. 
# You can use it as a singleton to handle logic from anywhere.

func go_to_level(level: String):
	get_tree().change_scene_to_file("res://levels/" + level + ".tscn")

var shape_circle: Texture2D = preload("res://textures/shapes/shape_circle.png") 
var shape_cone: Texture2D = preload("res://textures/shapes/shape_cone.png") 
var shape_cross: Texture2D = preload("res://textures/shapes/shape_cross.png") 
var shape_diamond: Texture2D = preload("res://textures/shapes/shape_diamond.png") 
var shape_funnel: Texture2D = preload("res://textures/shapes/shape_funnel.png")
var shape_square: Texture2D = preload("res://textures/shapes/shape_square.png")

enum Shape
{
	CIRCLE,
	CONE,
	CROSS,
	DIAMOND,
	FUNNEL,
	SQUARE
}

func get_texture(shape) -> Texture2D:
	match shape:
		Global.Shape.CIRCLE: return shape_circle
		Global.Shape.CONE: return shape_cone
		Global.Shape.CROSS: return shape_cross
		Global.Shape.DIAMOND: return shape_diamond
		Global.Shape.FUNNEL: return shape_funnel
		Global.Shape.SQUARE: return shape_square
	return null
