extends Node2D
var music : AudioStreamPlayer2D
var amb : AudioStreamPlayer2D
var sfx : AudioStreamPlayer2D


func _ready():
	amb = $Ambince
	music = $Music
	sfx = $SFX