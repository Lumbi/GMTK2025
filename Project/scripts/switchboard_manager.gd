extends Node2D

var switchboard_socket_scene = preload("res://prefabs/SwitchboardSocket.tscn")
var wire_prefab = preload("res://prefabs/Wire.tscn")
var socket_spacing = 140  # Distance between sockets
var start_pos :Vector2

var current_wire
var active_socketid : int = -1
var rows : int = 3
var cols : int = 3
var switchboard_socket_nodes: Array = []
var switchboard_scoekt_active_nodes : Array[Dictionary] = []

func _ready():
	# Set start_pos to the center of the window
	start_pos = get_viewport().get_visible_rect().size / 2
	spawn_switchboard_grid()
	
	# spawn the first wire
	spawn_wire(Vector2(100, 100))

func spawn_switchboard_grid():
	# Spawn a 3x3 grid of switchboard sockets
	for row in range(rows):
		for col in range(cols):
			var socket_instance = switchboard_socket_scene.instantiate()
			add_child(socket_instance)
			
			# Position the socket in a grid pattern
			var x_pos = (col - 1) * socket_spacing  # Center the grid
			var y_pos = (row - 1) * socket_spacing
			socket_instance.position = start_pos + Vector2(x_pos,y_pos) 
			socket_instance.socketid = (row *rows + col) 
			
			# Connect the input button signal to the manager
			socket_instance.get_node("InputSocket/InputButton").button_down.connect(_on_socket_input_button_down.bind(socket_instance))
			socket_instance.get_node("OutputSocket/OutputButton").button_down.connect(_on_socket_output_button_down.bind(socket_instance))
			
			# Optionally name each socket for easier identification
			socket_instance.name = "SwitchboardSocket_" + str(row) + "_" + str(col)
			switchboard_socket_nodes.append(socket_instance)

func _process(_delta: float) -> void:
	# move the current wire's end to mouse position
	if current_wire:
		var mouse_pos = get_viewport().get_mouse_position()
		var delta = mouse_pos - current_wire.global_position
		const MAX_WIRE_LENGTH = 700
		delta = delta.limit_length(MAX_WIRE_LENGTH)
		current_wire.move_end_to(current_wire.global_position + delta)

func on_socket_connected(socket: Node) -> void:
	var input_socket = socket.input_socket_node
	var output_socket = socket.output_socket_node
	if current_wire:
		current_wire.move_end_to(input_socket.global_position)
		switchboard_scoekt_active_nodes.append({"socket": socket, "wire": current_wire})
		current_wire.freeze()
		current_wire = null
		spawn_wire(output_socket.global_position)

func on_socket_disconected(_socket: Node) -> void:
	var last_wire_pair = switchboard_scoekt_active_nodes.pop_back() #previous wire 
	if last_wire_pair != null:
		var wire = last_wire_pair["wire"]
		current_wire.queue_free()
		current_wire = wire
		wire.unfreeze()
	if !switchboard_scoekt_active_nodes.is_empty(): 
		var previous_node = switchboard_scoekt_active_nodes.back()
		if previous_node:
			active_socketid = previous_node["socket"].socketid
		else:
			active_socketid = -1

func spawn_wire(spawn_position: Vector2) -> void:
	if not current_wire:
		current_wire = wire_prefab.instantiate()
		current_wire.global_position = spawn_position
		add_child(current_wire)

func _on_socket_input_button_down(socket: Node):
	if is_already_connected(socket) == false:
		on_socket_connected(socket)
		socket.swap_to_connected_socket()
		active_socketid = socket.socketid

func _on_socket_output_button_down(socket: Node):
	if active_socketid == socket.socketid:
		on_socket_disconected(socket)
		socket.swap_to_unconnected_socket()

func is_already_connected(scoket : Node):
	for socket_wire_pair in switchboard_scoekt_active_nodes:
		var previous_socket = socket_wire_pair["socket"]
		if scoket == previous_socket:
			return true
	return false
