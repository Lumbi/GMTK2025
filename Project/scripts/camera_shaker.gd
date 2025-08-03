extends Node

var camera

@export var shake_amount := 10.0
@export var shake_duration := 0.3
@export var shake_speed := 30.0
@export var shake_amplitude := 10
@export var curve:Curve


var shake_time := 0.0
var noise := FastNoiseLite.new()
var offset := Vector2.ZERO

func _ready():
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()
	
	
func evaluate(t:float):
	var intensity = curve.sample(t)
	offset.x = noise.get_noise_1d(t * shake_amplitude) * shake_amount
	offset.y = noise.get_noise_1d(t * shake_amplitude + 1000.0) * shake_amount
	%CameraContainer.global_position = offset* intensity
	
func shake():
	var tween = create_tween()
	tween.tween_method(evaluate,0.,1.,shake_duration)

	
	

#func _process(delta):
	#if shake_time > 0.0:
		#shake_time -= delta
		#var t := Time.get_ticks_msec()  / 1000.0 * shake_speed
		#offset.x = noise.get_noise_1d(t) * shake_amount
		#offset.y = noise.get_noise_1d(t + 1000.0) * shake_amount
		#offset *= clamp(shake_time / shake_duration, 0.0, 1.0)
		#offset = offset.lerp(Vector2.ZERO, delta * 5.0)  # Damping
	#else:
		#offset = offset.lerp(Vector2.ZERO, delta * 5.0)
	#
	 #camera_container.global_position = offset  # Applies shake to Camera2D position

	
	
