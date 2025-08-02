extends Node

# This script is automatically loaded globally. 
# You can use it as a singleton to handle logic from anywhere.

func go_to_level(level: String):
	get_tree().change_scene_to_file("res://levels/" + level + ".tscn")
