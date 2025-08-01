extends Node2D

var switchboard_socket_scene = preload("res://prefabs/SwitchboardSocket.tscn")
var wire_prefab = preload("res://prefabs/Wire.tscn")
var socket_spacing = 140  # Distance between sockets
var start_pos :Vector2

var current_wire

func _ready():
	# Set start_pos to the center of the window
	start_pos = get_viewport().get_visible_rect().size / 2
	spawn_switchboard_grid()
	
	# spawn the first wire
	spawn_wire(Vector2(100, 100))

func spawn_switchboard_grid():
	# Spawn a 3x3 grid of switchboard sockets
	for row in range(3):
		for col in range(3):
			var socket_instance = switchboard_socket_scene.instantiate()
			add_child(socket_instance)
			
			# Position the socket in a grid pattern
			var x_pos = (col - 1) * socket_spacing  # Center the grid
			var y_pos = (row - 1) * socket_spacing
			socket_instance.position = start_pos + Vector2(x_pos,y_pos) 
			
			# Optionally name each socket for easier identification
			socket_instance.name = "SwitchboardSocket_" + str(row) + "_" + str(col)

func _process(delta: float) -> void:
	# move the current wire's end to mouse position
	if current_wire:
		var mouse_pos = get_viewport().get_mouse_position()
		current_wire.move_end_to(mouse_pos)

func on_socket_connected(input_socket, output_socket) -> void:
	if current_wire:
		current_wire.move_end_to(input_socket.global_position)
		current_wire.freeze()
		current_wire = null
		spawn_wire(output_socket.global_position)

func spawn_wire(position: Vector2) -> void:
	if not current_wire:
		current_wire = wire_prefab.instantiate()
		current_wire.global_position = position
		add_child(current_wire)
