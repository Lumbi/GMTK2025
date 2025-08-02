extends Node2D

@onready var line2d: Line2D = $Line2D
@onready var plug:Node2D = $plug
@onready var plug_frist_point:Node2D = $plug_first_point
@onready var plug_plugged:Node2D = $plug_plugged

@export var colors:Array[Color]

var isFirstPointVisible = false

func set_plug_position():
	plug.global_position = line2d.points[line2d.points.size() - 1]
	
func _process(delta: float) -> void:
	set_plug_position()
	
	
func plug_wire():
	plug_plugged.visible = true
	plug_plugged.global_position = line2d.points[line2d.points.size()-1]
	plug.visible = false
	
func unplug_wire():
	plug_plugged.visible = false
	plug.visible = true
	
func _ready() -> void:
	set_random_color()
	if(isFirstPointVisible):
		enable_first_point_plug()


	
func enable_first_point_plug():
	plug_frist_point.visible = true	
	isFirstPointVisible = true	
	plug_frist_point.global_position = line2d.points[0]
	
func set_points(points:Array[Vector2]):
	line2d.clear_points()
	for p in points:
		line2d.add_point(p)
	
func set_color(color:Color):
	line2d.default_color = color
	
func set_random_color():
	set_color(colors[ randi_range(0,colors.size() -1)])
	
