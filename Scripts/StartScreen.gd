extends Control

signal start_game
signal open_settings
signal open_how_to_play

func _on_StartGame_pressed():
	emit_signal("start_game")

func _on_Settings_pressed():
	emit_signal("open_settings")

func _on_HowToPlay_pressed():
	emit_signal("open_how_to_play")

func _on_QuitButton_pressed():
	get_tree().quit()
