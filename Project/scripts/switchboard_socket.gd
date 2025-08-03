extends Node2D
@export var output_socket_not_connected: Texture2D = preload("res://textures/Socket_LED_Default.png")
@export var output_socket_connected: Texture2D = preload("res://textures/Socket_LED_BLUE.png") 
@export var input_socket_not_connected: Texture2D = preload("res://textures/Socket_LED_ON.png") 
@export var input_socket_connected: Texture2D = preload("res://textures/Socket_LED_Default.png") 
@export var shape: Global.Shape

var socket_connect_cursor_res = load("res://textures/socket_connect_cursor.png")
var socket_disconnect_cursor_res = load("res://textures/socket_disconnect_cursor.png")
var is_socket_connected : bool = false
var input_socket_node: Sprite2D
var output_socket_node: Sprite2D
var shape_sprite: Sprite2D
var socketid: int = -1
var switchboard_manager : Node

func _ready():
	# Get references to the socket nodes
	input_socket_node = $InputSocket
	output_socket_node = $OutputSocket
	shape_sprite = $Shape
	input_socket_node.texture = input_socket_not_connected
	output_socket_node.texture = output_socket_not_connected
	#randomize Shapes in Switchboard will be be more fun
	shape_sprite.texture = Global.get_texture(shape)
	switchboard_manager = get_node("../../../Switchboard")

func reset():
	is_socket_connected = false
	$InputSocket.texture = input_socket_not_connected
	$OutputSocket.texture = output_socket_not_connected

func _on_input_button_mouse_entered():
	if !is_socket_connected:
		if switchboard_manager.current_wire != null:
			Input.set_custom_mouse_cursor(socket_connect_cursor_res) ## avoid trying to connect from other switchboards 

func _on_input_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func _on_output_button_mouse_entered():
	if is_socket_connected:
		Input.set_custom_mouse_cursor(socket_disconnect_cursor_res)

func _on_output_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func swap_to_connected_socket():
	is_socket_connected = true
	input_socket_node.texture = input_socket_connected
	output_socket_node.texture = output_socket_connected

func swap_to_connected_socket_but_not_current_active():
	input_socket_node.texture = input_socket_connected
	output_socket_node.texture = output_socket_not_connected

func swap_to_unconnected_socket():
	is_socket_connected = false
	input_socket_node.texture = input_socket_not_connected
	output_socket_node.texture = output_socket_not_connected

func mark_as_max_connection_reached():
	if is_socket_connected == false :
		input_socket_node.texture = output_socket_not_connected
		output_socket_node.texture = output_socket_not_connected

func mark_as_max_connection_unreached():
	if is_socket_connected == false :
		swap_to_unconnected_socket()

func mark_as_inactive():
		input_socket_node.texture = output_socket_not_connected
		output_socket_node.texture = output_socket_not_connected
