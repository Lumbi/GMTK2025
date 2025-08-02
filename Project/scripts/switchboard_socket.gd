extends Node2D
@export var output_socket_not_connected: Texture2D = preload("res://textures/socket.png")
@export var output_socket_connected: Texture2D = preload("res://textures/output_socket.png") 
@export var input_socket_not_connected: Texture2D = preload("res://textures/input_socket.png") 
@export var input_socket_connected: Texture2D = preload("res://textures/socket.png") 
@export var shape: Global.Shape

var socket_connect_cursor_res = load("res://textures/socket_connect_cursor.png")
var is_socket_connected : bool = false
var input_socket_node: Sprite2D
var output_socket_node: Sprite2D
var shape_sprite: Sprite2D
var socketid: int = -1

func _ready():
	# Get references to the socket nodes
	input_socket_node = $InputSocket
	output_socket_node = $OutputSocket
	shape_sprite = $Shape
	input_socket_node.texture = input_socket_not_connected
	output_socket_node.texture = output_socket_not_connected
	#randomize Shapes in Switchboard will be be more fun
	shape_sprite.texture = Global.get_texture(shape)


func _on_input_button_mouse_entered():
	if !is_socket_connected:
		Input.set_custom_mouse_cursor(socket_connect_cursor_res)


func _on_input_button_mouse_exited():
	if !is_socket_connected:
		Input.set_custom_mouse_cursor(null)


func _on_output_button_mouse_entered():
	if is_socket_connected:
		Input.set_custom_mouse_cursor(socket_connect_cursor_res)


func _on_output_button_mouse_exited():
	if is_socket_connected:
		Input.set_custom_mouse_cursor(null)


func swap_to_connected_socket():
	is_socket_connected = true
	input_socket_node.texture = input_socket_connected
	output_socket_node.texture = output_socket_connected

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
