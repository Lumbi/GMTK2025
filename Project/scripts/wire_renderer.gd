extends Node2D

@onready var line2d: Line2D = $Line2D
@onready var plug:Node2D = $plug
@onready var plug_frist_point:Node2D = $plug_first_point
@onready var plug_plugged:Node2D = $plug_plugged


@export var cursorOffset:Vector2
@export var colors:Array[Color]

var isFirstPointVisible = false

var plugged:bool = false

func set_plug_position():
	plug.global_position = line2d.points[line2d.points.size() - 1]
	
func _process(delta: float) -> void:
	set_plug_position()
	
	
func plug_wire():
	plug_plugged.visible = true
	plug.visible = false
	plugged = true
	for i in  range(line2d.points.size()):
		if i == 0:
			continue
		line2d.set_point_position(i, line2d.get_point_position(i) - cursorOffset)
		
	plug_plugged.global_position = line2d.points[line2d.points.size()-1]
	
func unplug_wire():
	plug_plugged.visible = false
	plug.visible = true
	plugged = false
	
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
	for i in len(points):
		var p = points[i]
		
		var offset = Vector2(0,0)
		if(!plugged && i!=0):
			offset = cursorOffset
		line2d.add_point(p + offset)
	plug_plugged.global_position = line2d.get_point_position(len(points)-1)
	if(isFirstPointVisible):
		plug_frist_point.global_position = line2d.get_point_position(0)

		
	
	
func set_color(color:Color):
	line2d.default_color = color
	
func set_random_color():
	set_color(colors[ randi_range(0,colors.size() -1)])
	
