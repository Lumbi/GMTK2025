extends Node2D

var switchboard_socket_scene = preload("res://prefabs/SwitchboardSocket.tscn")
var wire_prefab = preload("res://prefabs/Wire.tscn")
var socket_spacing = 140  # Distance between sockets

@export var rows : int = 3
@export var cols : int = 3
@export var max_connections : int = 2
@export var puzzleType : Global.PuzzleType = Global.PuzzleType.LARGE
@export var shapeStations_filename_to_key : Dictionary[String,String] = {}

var current_wire
var active_socketid : int = -1
var switchboard_active_socket_nodes : Array[Dictionary] = []
var switchboard_sockets : Array = []
var shape_dial : Node
var audio_dialogstation : Node

var shapes : Array[Texture2D] = []

func _ready():
	shape_dial = $ShapeDial
	audio_dialogstation = $AudioStationManager
	var date_type = Global.get_puzzletype_to_date(puzzleType)
	shape_dial.set_hint_text(date_type)
	# Collect all SwitchboardSocket children
	collect_switchboard_sockets()

func activate():
	# spawn the first wire
	spawn_wire(%FirstWireSpawnPoint.global_position)

func inactive():
	# spawn the first wire
	for switchboard_socket in switchboard_sockets:
		switchboard_socket.mark_as_inactive()

func reset():
	active_socketid = -1
	# free current wire
	if current_wire:
		current_wire.queue_free()
		current_wire = null
	# free all other active wires
	for active_socket_node in switchboard_active_socket_nodes:
		var wire = active_socket_node["wire"]
		if wire: wire.queue_free()
	# reset all sockets
	for socket in switchboard_sockets:
		if socket: socket.reset()
	# clear active sockets
	switchboard_active_socket_nodes.clear()
	# reset shape dial
	$ShapeDial.reset()

func collect_switchboard_sockets():
	var switchboard_sockets_node = %SwitchboardSockets
	if switchboard_sockets_node:
		switchboard_sockets = switchboard_sockets_node.get_children()
		var index = 0
		for socket_instance in switchboard_sockets:
			# Connect the input button signal to the manager
			socket_instance.get_node("InputSocket/InputButton").button_down.connect(_on_socket_input_button_down.bind(socket_instance))
			socket_instance.get_node("OutputSocket/OutputButton").button_down.connect(_on_socket_output_button_down.bind(socket_instance))
			socket_instance.socketid = index
			index += 1 
		


func spawn_switchboard_grid():
	# Set start_pos to the center of the window
	var start_pos = get_viewport().get_visible_rect().size / 2
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
			switchboard_sockets.append(socket_instance)

func _process(_delta: float) -> void:
	# move the current wire's end to mouse position
	if current_wire:
		var mouse_pos = get_global_mouse_position()
		var delta = mouse_pos - current_wire.global_position
		const MAX_WIRE_LENGTH = 850	
		delta = delta.limit_length(MAX_WIRE_LENGTH)
		current_wire.move_end_to(current_wire.global_position + delta)

func check_previous_node_connected_but_not_current_active() -> void:
	if !switchboard_active_socket_nodes.is_empty(): 
		var previous_node = switchboard_active_socket_nodes.back()["socket"]
		previous_node.swap_to_connected_socket_but_not_current_active()

func on_socket_connected(socket: Node) -> void:
	GlobalAudio.play_sfx("2025_GMTL_sfx_in")

	var input_socket = socket.input_socket_node
	var output_socket = socket.output_socket_node
	check_previous_node_connected_but_not_current_active()
	if current_wire:
		current_wire.move_end_to(input_socket.global_position)
		switchboard_active_socket_nodes.append({"socket": socket, "wire": current_wire})
		current_wire.freeze()
		current_wire.wire_renderer.plug_wire()
		current_wire = null
		spawn_wire(output_socket.global_position)
		shape_dial.toggle_shape(socket.shape)
	var start_dialog = audio_dialogstation.try_to_start_audio()

	if switchboard_active_socket_nodes.size() >= max_connections:
		if start_dialog == false : 
			GlobalAudio.play_sfx("fail_sfx")
		max_connections_reached()

func on_socket_disconected(_socket: Node) -> void:
	var last_wire_pair = switchboard_active_socket_nodes.pop_back() #previous wire 
	if last_wire_pair != null:
		GlobalAudio.play_sfx("2025_GMTL_sfx_out")
		var wire = last_wire_pair["wire"]
		var socket = last_wire_pair["socket"]
		shape_dial.toggle_shape(socket.shape)
		current_wire.queue_free()
		current_wire = wire
		current_wire.wire_renderer.unplug_wire()
		wire.unfreeze()
	if !switchboard_active_socket_nodes.is_empty(): 
		var previous_node = switchboard_active_socket_nodes.back()
		if previous_node:
			var previous_socket = previous_node["socket"]
			active_socketid = previous_socket.socketid
			previous_socket.swap_to_connected_socket()
		else:
			active_socketid = -1
	if switchboard_active_socket_nodes.size() < max_connections:
		max_connections_unreached()

func spawn_wire(spawn_position: Vector2) -> void:
	if not current_wire:
		current_wire = wire_prefab.instantiate()
		add_child(current_wire)
		current_wire.global_position = spawn_position
		current_wire.wire_renderer.enable_first_point_plug()

func _on_socket_input_button_down(socket: Node):
	if current_wire:
		if is_already_connected(socket) == false and switchboard_active_socket_nodes.size() < max_connections:
			on_socket_connected(socket)
			socket.swap_to_connected_socket()
			active_socketid = socket.socketid

func _on_socket_output_button_down(socket: Node):
	if active_socketid == socket.socketid:
		on_socket_disconected(socket)
		socket.swap_to_unconnected_socket()

func is_already_connected(scoket : Node):
	for socket_wire_pair in switchboard_active_socket_nodes:
		var previous_socket = socket_wire_pair["socket"]
		if scoket == previous_socket:
			return true
	return false

func max_connections_reached():
	for switchboard_socket in switchboard_sockets:
		switchboard_socket.mark_as_max_connection_reached()

func max_connections_unreached():
	for switchboard_socket in switchboard_sockets:
		switchboard_socket.mark_as_max_connection_unreached()
