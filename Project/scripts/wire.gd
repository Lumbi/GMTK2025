extends Node2D

var wire_segment_prefab = preload("res://prefabs/WireSegment.tscn")

var segment_pair_count = 20
var spacing = 20
var segments = []

func move_end_to(p: Vector2):
	var end_pin = $"EndPinStaticBody"
	end_pin.global_position = p

func _ready() -> void:
	var start_pin = $"StartPinStaticBody"
	var end_pin = $"EndPinStaticBody"
	var start_pin_joint = $"%StartPinJoint2D"
	var end_pin_joint = $"%EndPinJoint2D"
	
	var segment_a = wire_segment_prefab.instantiate()
	segment_a.position.y = start_pin.position.y
	segments.append(segment_a)
	add_child(segment_a)

	var segment_b # will be created in the loop
	
	var first_segment = segment_a
	var last_segment # will be set after the loop
	
	for n in segment_pair_count:
		segment_b = wire_segment_prefab.instantiate()
		add_child(segment_b)
		segments.append(segment_b)
		# position segment_b below segment_a
		var shape_a = segment_a.get_node("%CollisionShape2D").get_shape()
		var segment_a_end = segment_a.position.y + shape_a.get_rect().size.y
		segment_b.position.y = segment_a.position.y + shape_a.get_rect().size.y + spacing

		var joint = PinJoint2D.new()
		joint.node_a = segment_a.get_path()
		joint.node_b = segment_b.get_path()
		# put the joint in between both
		joint.position.y = segment_a_end + (spacing / 2.0)
		add_child(joint)
		
		segment_a = segment_b # swap

	last_segment = segment_a	
	
	end_pin.position.x = last_segment.position.x
	var last_segment_shape = last_segment.get_node("%CollisionShape2D").get_shape()
	var last_segment_end = last_segment.position.y + last_segment_shape.get_rect().size.y
	end_pin.position.y = last_segment_end
	
	# tie the ends
	start_pin_joint.node_b = first_segment.get_path()
	end_pin_joint.node_a = last_segment.get_path()

func _draw() -> void:
	var start_pin = $"StartPinStaticBody"
	var end_pin = $"EndPinStaticBody"
	
	var start_pos = start_pin.position
	var end_pos
	for segment in segments:
		end_pos = segment.position
		draw_line(start_pos, end_pos, Color.GREEN, 10)
		start_pos = end_pos
