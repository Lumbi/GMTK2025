extends Node2D
var music : AudioStreamPlayer2D
var amb : AudioStreamPlayer2D
var sfx : AudioStreamPlayer2D
var  is_voice_playing : bool = false
var  is_ducking : bool = false
@export var db_to_duck_while_voice_is_playing : int  = 9

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
	amb.volume_db -= db_to_duck_while_voice_is_playing
	music.volume_db -= db_to_duck_while_voice_is_playing

func unduck_volume() -> void:
	amb.volume_db += db_to_duck_while_voice_is_playing
	music.volume_db += db_to_duck_while_voice_is_playing