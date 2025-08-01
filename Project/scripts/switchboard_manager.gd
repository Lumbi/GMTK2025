extends Node2D

var switchboard_socket_scene = preload("res://prefabs/SwitchboardSocket.tscn")
var socket_spacing = 140  # Distance between sockets
var start_pos :Vector2

func _ready():
	# Set start_pos to the center of the window
	start_pos = get_viewport().get_visible_rect().size / 2
	spawn_switchboard_grid()

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


