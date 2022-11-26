extends Node

var meteor_scene = preload("res://Scenes/Meteor.tscn")
var meteor_speed = 50

func _process(_delta):
#Closes the game
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_MeteorTimer_timeout():
	var meteor = meteor_scene.instance()
	var meteor_spawn_location = get_node("MeteorPath/MeteorSpawnLocation")
	meteor_spawn_location.offset = randi()
	meteor.position = meteor_spawn_location.position
	meteor.linear_velocity = meteor_speed * meteor.position.direction_to($Earth.position)
	add_child(meteor)
	meteor.add_to_group("meteors")
