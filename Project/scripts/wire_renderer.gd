extends Node2D

@onready var line2d: Line2D = $Line2D

@export var colors:Array[Color]

func set_points(points:Array[Vector2]):
	line2d.clear_points()
	for p in points:
		line2d.add_point(p)
	
func set_color(color:Color):
	line2d.default_color = color
	
func set_random_color():
	set_color(colors[ randi_range(0,colors.size() -1)])
	
