extends Area2D

func _physics_process(delta):
	if Input.is_action_pressed("left_click") and get_node("/root/Node").push_fuel:
		gravity = -500
		get_node("/root/Node").use_push_fuel()
	elif Input.is_action_pressed("right_click") and get_node("/root/Node").pull_fuel:
		gravity = 500
		get_node("/root/Node").use_pull_fuel()
	else:
		gravity = 100
