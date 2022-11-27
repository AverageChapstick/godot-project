extends Area2D

var alive = false

func _physics_process(_delta):
	if alive:
		if Input.is_action_pressed("left_click") and get_node("/root/Node").push_fuel:
			gravity = -500
			get_node("/root/Node").use_push_fuel()
			$PushWave.active = true
			$PullWave.active = false
			for wave in $PullWave.waves:
				wave.wave_speed = 0.02
		elif Input.is_action_pressed("right_click") and get_node("/root/Node").pull_fuel:
			gravity = 500
			get_node("/root/Node").use_pull_fuel()
			$PullWave.active = true
			$PullWave.wave_speed = 0.007
			for wave in $PullWave.waves:
				wave.wave_speed = 0.007
			$PushWave.active = false
		else:
			gravity = 100
			$PullWave.active = true
			$PullWave.wave_speed = 0.003
			$PushWave.active = false
