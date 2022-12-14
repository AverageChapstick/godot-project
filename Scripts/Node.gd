extends Node

signal big_screenshake
signal small_screenshake
var screen_shake_enabled = true

var meteor_scene = preload("res://Scenes/Meteor.tscn")
var earth_health = 28
var station_health = 28
var push_fuel = 28
var pull_fuel = 28
var score = 0
var high_score = 0

var fuel_consumption = 0.3
var fuel_receive = 5
var difficulty_increase = 0.002
var difficulty_cap = 0.5 # minimal time between meteor spawning
var meteor_speed = 50
var station_damage = 5
var earth_damage = 5

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -10)
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
	
	score += 1
	$Score.text = str(score)

func earth_hit():
	if earth_health > 0:
		earth_health -= rand_range(0, earth_damage)
		$HUD/EarthHealth/EarthHealthBar.frame = round(earth_health)
		if screen_shake_enabled:
			emit_signal("big_screenshake")
	if earth_health < 1:
		$Earth.hide()
		$Earth.set_collision_layer_bit(0, 0)
		$Earth.set_collision_mask_bit(0, 0)
		$HUD.hide()
		$Score.hide()
		$GameoverMessage.show()
		$GameoverMessage/ScoreMessage.text = "it took " + str(score) + " meteors to destroy your earth!"
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
		$Highscore.show()
		if score > high_score:
			high_score = score
			$Highscore.text = "current highscore: " + str(score)

func station_hit():
	if station_health > 0:
		station_health -= rand_range(0, station_damage)
		if screen_shake_enabled:
			emit_signal("small_screenshake")
		$HUD/StationHealth/StationHealthBar.frame = round(station_health)
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
	if push_fuel < 28:
		push_fuel += fuel_receive
	$HUD/PushFuel/PushFuelBar.frame = push_fuel

func get_pull_fuel():
	if push_fuel < 28:
		pull_fuel += randi() % fuel_receive
	$HUD/PullFuel/PullFuelBar.frame = pull_fuel

func use_push_fuel():
	push_fuel -= fuel_consumption
	$HUD/PushFuel/PushFuelBar.frame = round(push_fuel)

func use_pull_fuel():
	pull_fuel -= fuel_consumption
	$HUD/PullFuel/PullFuelBar.frame = round(pull_fuel)

func _on_EarthGravity_body_entered(body):
	body.queue_free()

func _on_SpawnRateTimer_timeout():
	if $MeteorTimer.wait_time > difficulty_cap:
		$MeteorTimer.wait_time -= difficulty_increase

func _on_StartScreen_start_game():
	$StartScreen.hide()
	$Earth.show()
	$HUD.show()
	$Score.show()
	
	earth_health = 28
	station_health = 28
	push_fuel = 28
	pull_fuel = 28
	score = 0
	$Highscore.hide()
	$Score.show()
	
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
	$StartScreen.hide()
	$Settings.show()

func _on_StartScreen_open_how_to_play():
	$StartScreen.hide()
	$HowToPlayScreen.show()

func _on_Settings_return_pressed():
	$Settings.hide()
	$StartScreen.show()

func _on_HowToPlayScreen_return_pressed():
	$HowToPlayScreen.hide()
	$StartScreen.show()
	
func _on_Settings_toggled_glow():
	$WorldEnvironment.environment.glow_enabled = not $WorldEnvironment.environment.glow_enabled

func _on_Settings_toggled_shake():
	screen_shake_enabled = not screen_shake_enabled

func _on_Settings_set_sound(value):
	if not value:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value / 2 - 35)
