extends Node


var test_dialogue = load("res://dialogues/test.dialogue")
var shape_dial : Node
var switchboard_manager : Node
var dialog_player : Node

class ShapeStation:
	var shape: String
	var dialog : Resource
	var audio: AudioStream


	func _init(s: String, d: Resource, st: AudioStream,):
		shape = s
		dialog = d
		audio = st


var shapeStations : Array[ShapeStation] = []

func _ready():
	shape_dial = %ShapeDial
	switchboard_manager = get_node("../../Switchboard")
	dialog_player = %DialogPlayer
	print(test_dialogue.get_class())
	var puzzle_type = Global.get_puzzletype(switchboard_manager.puzzleType)

	DialogueManager.dialogue_started.connect(dialogue_started)
	DialogueManager.dialogue_ended.connect(dialogue_ended)

	for shape_station in switchboard_manager.shapeStations_filename_to_key.keys():
		var station_name_forfiles = switchboard_manager.shapeStations_filename_to_key[shape_station]

		var dialog_path = get_dialog_name(station_name_forfiles, puzzle_type)
		var dialog_file = load(dialog_path)

		var vo_path = get_vo_path(station_name_forfiles, puzzle_type)
		var vo_file = load(vo_path)

		var circle_station = ShapeStation.new(shape_station, dialog_file, vo_file)
		shapeStations.append(circle_station)
	
	#	DialogueManager.show_dialogue_balloon(test_dialogue, "start")

func get_dialog_name(shape_station : String, puzzle_size : String):
	var resouce_path = "res://dialogues/puzzle_" +puzzle_size + "_" + shape_station + ".dialogue"
	return resouce_path

func get_vo_path(shape_station : String, puzzle_size : String):
	var resouce_path = "res://audio/dialogs/" +puzzle_size + "_" + shape_station + ".ogg"
	return resouce_path

func try_to_start_audio():
	var dialog_code = shape_dial.get_dial_code()
	for shape_station in shapeStations:
		if shape_station.shape == dialog_code:
			DialogueManager.show_dialogue_balloon(shape_station.dialog, "start")
			dialog_player.stream = shape_station.audio
			dialog_player.play()


func dialogue_started(resource: DialogueResource):
	pass

func dialogue_ended(resource: DialogueResource):
	dialog_player.stop()
	if switchboard_manager.active_socketid >= 0:
		switchboard_manager.reset()
		switchboard_manager.activate()