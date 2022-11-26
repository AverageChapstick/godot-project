extends Area2D

func _physics_process(delta):
	var vel := (get_global_mouse_position() - global_position)
	position += vel
	pass
