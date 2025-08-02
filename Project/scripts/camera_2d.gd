extends Camera2D

var is_in_transition = false
var transition_time = 0.0
const TRANSITION_DURATION = 0.5

var start_zoom
var target_zoom

var start_offset
var target_offset

func zoom_to(p_target_zoom, p_target_offset):
	is_in_transition = true
	transition_time = 0.0
	start_zoom = zoom.x
	target_zoom = p_target_zoom
	start_offset = offset
	target_offset = p_target_offset

func _process(_delta: float) -> void:
	if is_in_transition:
		var alpha = transition_time / TRANSITION_DURATION
		alpha = ease(alpha, -1)
		offset = lerp(start_offset, target_offset, alpha)
		zoom.x = lerp(start_zoom, target_zoom, alpha)
		zoom.y = zoom.x

		if transition_time < TRANSITION_DURATION:
			transition_time += _delta
		transition_time = clamp(transition_time, 0.0, TRANSITION_DURATION)
		
		if transition_time >= TRANSITION_DURATION:
			is_in_transition = false
	pass
