extends Area2D

func _physics_process(delta):
	if Input.is_action_pressed("left_click"):
		gravity = -500
	elif Input.is_action_pressed("right_click"):
		gravity = 500
	else:
		gravity = 100
