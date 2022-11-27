extends Area2D

#var push_wave_scene = preload("res://Scenes/PushWave.tscn")
#
#func _ready():
#	for i in range(4):
#		add_child(push_wave_scene.instance())
#		yield(get_tree().create_timer(0.5), "timeout")

func _physics_process(_delta):
	if Input.is_action_pressed("left_click") and get_node("/root/Node").push_fuel:
		gravity = -500
#		get_node("/root/Node").use_push_fuel()
		$PushWave.active = true
	elif Input.is_action_pressed("right_click") and get_node("/root/Node").pull_fuel:
		gravity = 500
		get_node("/root/Node").use_pull_fuel()
		$PushWave.active = false
	else:
		gravity = 100
		$PushWave.active = false
