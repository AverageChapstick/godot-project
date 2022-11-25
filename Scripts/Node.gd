extends Node

func _ready():
	print("hello world!")


func _process(_delta):
#Closes the game
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
