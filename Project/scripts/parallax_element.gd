extends Node2D

var start_offset: Vector2
var camera:Camera2D

@export var depth:float

func _init() -> void:
	start_offset = global_position
	
	
func _process(delta: float) -> void:
	camera = get_viewport().get_camera_2d()
	var offset_vector:Vector2 =  start_offset - camera.transform.get_origin()
	var dir = offset_vector.normalized()
	var dist = offset_vector.length()
	
	global_position = start_offset - dir*dist*depth	
	 
	
