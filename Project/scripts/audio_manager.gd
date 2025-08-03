extends Node2D
var music : AudioStreamPlayer2D
var amb : AudioStreamPlayer2D
var sfx : AudioStreamPlayer2D
var  is_voice_playing : bool = false
var  is_ducking : bool = false
@export var music_duck_db : int  = 12
@export var amb_duck_db : int  = 9

func _ready():
	amb = $Ambince
	music = $Music
	sfx = $SFX

func _process(_delta: float) -> void:
	if is_voice_playing == true and is_ducking == false:
		duck_volume()
		is_ducking = true
	elif is_voice_playing == false and is_ducking == true:
		unduck_volume()
		is_ducking = false


func duck_volume() -> void:
	amb.volume_db -= amb_duck_db
	music.volume_db -= music_duck_db

func unduck_volume() -> void:
	amb.volume_db += amb_duck_db
	music.volume_db += music_duck_db

func OnCamearaZoomed(zoomed_in : bool) -> void:
	if zoomed_in == true:
		amb.play()
	else:
		amb.stop()