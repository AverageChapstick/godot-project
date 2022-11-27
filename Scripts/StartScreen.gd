extends Control

signal start_game
signal open_settings
signal open_how_to_play

func _on_StartGame_pressed():
	emit_signal("start_game")
	$Start.playing = true
	
func _on_Settings_pressed():
	emit_signal("open_settings")
	$Start.playing = true

func _on_HowToPlay_pressed():
	emit_signal("open_how_to_play")
	$Start.playing = true
	
func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartGame_mouse_entered():
	$Hover.playing = true

func _on_Settings_mouse_entered():
	$Hover.playing = true

func _on_HowToPlay_mouse_entered():
	$Hover.playing = true
