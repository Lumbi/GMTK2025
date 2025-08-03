extends Node

var sfx_dictionary: Dictionary = {}

var sfx_mix: Dictionary[String, float] = {
	"2025_GMTL_sfx_in" : -3,
	"2025_GMTL_sfx_out" : -3,
	"2025_GMTL_sfx_date_panel" : 9,
	"TvOn_crt" : 6,
}

func get_audio_manager():
	return AudioManager

func _ready():
	load_all_sfx_files()

func get_key_from_filename(file_name):
	var key = file_name.get_basename()
	var last_char = key[-1]
	if last_char.is_valid_int():
		return key.substr(0, key.length() - 2);
	return key

func load_all_sfx_files():
	var dir = DirAccess.open("res://audio/sfx")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if !dir.current_is_dir() and is_audio_file(file_name):
				var audio_path = "res://audio/sfx/" + file_name
				var audio_stream = load(audio_path)
				if audio_stream:
					# Use filename without extension as key
					var key = get_key_from_filename(file_name)
					if sfx_dictionary.has(key):
						sfx_dictionary[key].append(audio_stream)
					else:
						sfx_dictionary[key] = [audio_stream]
					print("Loaded SFX: ", key, " -> ", file_name)
			file_name = dir.get_next()
		
		dir.list_dir_end()
		print("Total SFX files loaded: ", sfx_dictionary.size())
	else:
		print("Error: Could not open audio/sfx directory")

func is_audio_file(file_name: String) -> bool:
	var audio_extensions = [".wav", ".ogg", ".mp3", ".flac"]
	for ext in audio_extensions:
		if file_name.ends_with(ext):
			return true
	return false

func get_sfx(sfx_name: String) -> AudioStream:
	if sfx_dictionary.has(sfx_name):
		var random_num = randi() % sfx_dictionary[sfx_name].size()
		return sfx_dictionary[sfx_name][random_num]
	else:
		print("Warning: SFX '", sfx_name, "' not found")
		return null

func play_sfx_on_player(sfx_name: String, audio_player: AudioStreamPlayer2D):
	var sfx = get_sfx(sfx_name)
	if sfx:
		var vol = get_mix_value(sfx_name)
		audio_player.stream = sfx
		audio_player.play()

func get_mix_value(sfx_name: String):
	if sfx_mix.has(sfx_name):
		return sfx_mix[sfx_name]
	else:
		return 0

func play_sfx(sfx_name: String):
	play_sfx_on_player(sfx_name, get_audio_manager().sfx)


func get_all_sfx_names() -> Array[String]:
	return sfx_dictionary.keys()

func set_dialog_is_playing(is_playing : bool) -> void:
	get_audio_manager().is_voice_playing = is_playing

func set_zoom_on_board(zoomed_in : bool) -> void:
	get_audio_manager().OnCamearaZoomed(zoomed_in)
