extends Node2D

@onready var line2d: Line2D = $Line2D

func set_points(points:Array[Vector2]):
	line2d.clear_points()
	for p in points:
		line2d.add_point(p)
	
