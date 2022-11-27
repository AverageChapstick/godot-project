extends Node

signal big_screenshake
signal small_screenshake

var meteor_scene = preload("res://Scenes/Meteor.tscn")
var meteor_speed = 50
var earth_health = 28
var station_health = 28
var push_fuel = 28
var pull_fuel = 28

func _ready():
	randomize()

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_MeteorTimer_timeout():
	if $MeteorTimer.wait_time > 0.5:
		$MeteorTimer.wait_time -= 0.05
	var meteor = meteor_scene.instance()
	var meteor_spawn_location = get_node("MeteorPath/MeteorSpawnLocation")
	meteor_spawn_location.offset = randi()
	meteor.position = meteor_spawn_location.global_position
	meteor.linear_velocity = rand_range(meteor_speed / 5, meteor_speed) * meteor.position.direction_to($Earth.position)
	add_child(meteor)
	meteor.add_to_group("meteors")

func earth_hit():
	if earth_health > 0:
		earth_health -= randi() % 4 + 1
		$HUD/EarthHealth/EarthHealthBar.frame = earth_health
		emit_signal("big_screenshake")
	if earth_health < 1:
		$Earth.hide()
		$Earth.set_collision_layer_bit(0, 0)
		$Earth.set_collision_mask_bit(0, 0)
		$HUD.hide()
		$GameoverMessage.show()
		$MeteorTimer.stop()
		yield(get_tree().create_timer(3.0), "timeout")
		$GameoverMessage.hide()
		$StartScreen.show()
		get_tree().call_group("meteors", "queue_free")
		
		$MousePosition.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$MousePosition/MouseGravity.alive = false
		$MousePosition/MouseGravity/PullWave.active = false
		$MousePosition/MouseGravity/PushWave.active = false

func station_hit():
	if station_health > 0:
		station_health -= randi() % 4 + 1
		emit_signal("small_screenshake")
		$HUD/StationHealth/StationHealthBar.frame = station_health
	if station_health < 1:
		$MousePosition/KinematicBody2D.set_collision_layer_bit(0, 0)
		$MousePosition/KinematicBody2D.set_collision_mask_bit(0, 0)
		$MousePosition.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$MousePosition/MouseGravity.alive = false
		$MousePosition/MouseGravity.gravity = 0
		$MousePosition/MouseGravity/PullWave.active = false
		$MousePosition/MouseGravity/PushWave.active = false

func get_push_fuel():
	push_fuel += 5
	$HUD/PushFuel/PushFuelBar.frame = push_fuel

func get_pull_fuel():
	pull_fuel += randi() % 5
	$HUD/PullFuel/PullFuelBar.frame = pull_fuel

func use_push_fuel():
	if not randi() % 3:
		push_fuel -= 1
		$HUD/PushFuel/PushFuelBar.frame = push_fuel

func use_pull_fuel():
	if not randi() % 3:
		pull_fuel -= 1
		$HUD/PullFuel/PullFuelBar.frame = pull_fuel

func _on_EarthGravity_body_entered(body):
	body.queue_free()

func _on_StartScreen_start_game():
	$StartScreen.hide()
	$Earth.show()
	$HUD.show()
	
	earth_health = 28
	station_health = 28
	push_fuel = 28
	pull_fuel = 28
	
	$MeteorTimer.wait_time = 2
	$SpawnRateTimer.start()
	
	$MousePosition.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$MousePosition/KinematicBody2D.set_collision_layer_bit(0, 1)
	$MousePosition/KinematicBody2D.set_collision_mask_bit(0, 1)
	$Earth.set_collision_layer_bit(0, 1)
	$Earth.set_collision_mask_bit(0, 1)
	$MousePosition/MouseGravity.alive = true
	$HUD/EarthHealth/EarthHealthBar.frame = earth_health
	$HUD/StationHealth/StationHealthBar.frame = station_health
	$HUD/PushFuel/PushFuelBar.frame = push_fuel
	$HUD/PullFuel/PullFuelBar.frame = pull_fuel
	$MeteorTimer.start()
	_on_MeteorTimer_timeout()
	
func _on_StartScreen_open_settings():
	pass # Replace with function body.

func _on_StartScreen_open_how_to_play():
	pass # Replace with function body.

func _on_SpawnRateTimer_timeout():
	if $MeteorTimer.wait_time > 0.5:
		$MeteorTimer.wait_time -= 0.005
