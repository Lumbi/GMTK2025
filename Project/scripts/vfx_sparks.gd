extends Node2D

func play():
	var particles = find_children("*","CPUParticles2D")
	for particle in particles:
		particle.emitting = true
