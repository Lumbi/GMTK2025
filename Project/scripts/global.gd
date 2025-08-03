extends Node

# This script is automatically loaded globally. 
# You can use it as a singleton to handle logic from anywhere.

func win_game():
	go_to_level("win")

func go_to_level(level: String):
	get_tree().change_scene_to_file("res://levels/" + level + ".tscn")

var shape_circle: Texture2D = preload("res://textures/shapes/shape_circle.png") 
var shape_triangle: Texture2D = preload("res://textures/shapes/shape_cone.png") 
var shape_cross: Texture2D = preload("res://textures/shapes/shape_cross.png") 
var shape_diamond: Texture2D = preload("res://textures/shapes/shape_diamond.png") 
var shape_funnel: Texture2D = preload("res://textures/shapes/shape_funnel.png")
var shape_square: Texture2D = preload("res://textures/shapes/shape_square.png")

enum Shape
{
	CIRCLE,
	TRIANGLE,
	CROSS,
	DIAMOND,
	FUNNEL,
	SQUARE
}

enum PuzzleType
{
	LARGE,
	MEDIUM,
	SMALL
}

func get_texture(shape) -> Texture2D:
	match shape:
		Global.Shape.CIRCLE: return shape_circle
		Global.Shape.TRIANGLE: return shape_triangle
		Global.Shape.CROSS: return shape_cross
		Global.Shape.DIAMOND: return shape_diamond
		Global.Shape.FUNNEL: return shape_funnel
		Global.Shape.SQUARE: return shape_square
	return null
	
func get_puzzletype(puzzletype : Global.PuzzleType) -> String:
	match puzzletype:
		Global.PuzzleType.LARGE: return "large"
		Global.PuzzleType.MEDIUM: return "medium"
		Global.PuzzleType.SMALL: return "small"
	return ""

func get_puzzletype_to_date(puzzletype: Global.PuzzleType) -> String:
	match puzzletype:
		Global.PuzzleType.LARGE: return "Year"
		Global.PuzzleType.MEDIUM: return "Month"
		Global.PuzzleType.SMALL: return "Day"
	return ""
