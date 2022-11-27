extends RigidBody2D

var alive = true

func _on_Meteor_body_entered(body):
	if body.is_in_group("station"):
		emit_signal("station_hit")
		get_node("/root/Node").station_hit()
		despawn()
	elif body.is_in_group("earth"):
		get_node("/root/Node").earth_hit()
		despawn()
	else:
		if randi() % 2:
			get_node("/root/Node").get_push_fuel()
			despawn()

func _process(_delta):
	if not $Timer.time_left and alive:
		if not position.x == clamp(position.x, -10, 250) or not position.y == clamp(position.y, -10, 145):
			get_node("/root/Node").get_pull_fuel()
			queue_free()

func despawn():
	alive = false
	linear_damp = 2
	angular_damp = 10
	$Sprite.visible = false
	$Particles2D.emitting = true
	$Explosion.volume_db = rand_range(-3, 5)
	$Explosion.pitch_scale = rand_range(1, 2)
	$Explosion.playing = true
	set_collision_layer_bit(0, 0)
	set_collision_mask_bit(0, 0)
	yield(get_tree().create_timer(3.0), "timeout")
	queue_free()
