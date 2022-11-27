extends RigidBody2D

func _on_Meteor_body_entered(body):
	if body.is_in_group("station"):
		emit_signal("station_hit")
		get_node("/root/Node").station_hit()
		despawn()
	elif body.is_in_group("earth"):
		get_node("/root/Node").earth_hit()
		queue_free()
	else:
		if randi() % 2:
			get_node("/root/Node").get_push_fuel()
			despawn()

func _process(_delta):
	if not $Timer.time_left:
		if not position.x == clamp(position.x, -10, 250) or not position.y == clamp(position.y, -10, 145):
			get_node("/root/Node").get_pull_fuel()
			despawn()

func despawn():
	$Sprite.visible = false
	$Particles2D.emitting = true
	$Explosion.playing = true
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
