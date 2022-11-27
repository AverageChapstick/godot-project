extends Node

var meteor_scene = preload("res://Scenes/Meteor.tscn")
var meteor_speed = 50
var earth_health = 28
var station_health = 28
var push_fuel = 28
var pull_fuel = 28

func _ready():
	_on_MeteorTimer_timeout()
#	connect("earth_hit", self, "earth_hit")
#	connect("station_hit", self, "station_hit")

func _process(_delta):
#Closes the game
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_MeteorTimer_timeout():
	var meteor = meteor_scene.instance()
	var meteor_spawn_location = get_node("MeteorPath/MeteorSpawnLocation")
	meteor_spawn_location.offset = randi()
	meteor.position = meteor_spawn_location.global_position
	meteor.linear_velocity = meteor_speed * meteor.position.direction_to($Earth.position)
	add_child(meteor)
	meteor.add_to_group("meteors")

func earth_hit():
	if earth_health > 0:
		earth_health -= 1
		$HUD/EarthHealth/EarthHealthBar.frame = earth_health
	if earth_health < 1:
		$Earth.visible = false

func station_hit():
	if station_health > 0:
		station_health -= 1
	$HUD/StationHealth/StationHealthBar.frame = station_health

func get_push_fuel():
	push_fuel += 1
	$HUD/PushFuel/PushFuelBar.frame = push_fuel

func get_pull_fuel():
	pull_fuel += 1
	$HUD/PullFuel/PullFuelBar.frame = pull_fuel

func use_push_fuel():
	push_fuel -= 1
	$HUD/PushFuel/PushFuelBar.frame = push_fuel

func use_pull_fuel():
	pull_fuel -= 1
	$HUD/PullFuel/PullFuelBar.frame = pull_fuel

func _on_EarthGravity_body_entered(body):
	body.queue_free()
