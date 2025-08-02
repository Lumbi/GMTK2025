extends Node2D

@onready var line2d: Line2D = $Line2D
@onready var plug:Node2D = $plug

@export var colors:Array[Color]


func set_plug_position():
	plug.global_position = line2d.points[line2d.points.size() - 1]
	
func _process(delta: float) -> void:
	set_plug_position()
	
func _ready() -> void:
	set_random_color()

func set_points(points:Array[Vector2]):
	line2d.clear_points()
	for p in points:
		line2d.add_point(p)
	
func set_color(color:Color):
	line2d.default_color = color
	
func set_random_color():
	set_color(colors[ randi_range(0,colors.size() -1)])
	
