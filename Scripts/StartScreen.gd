extends Control

signal start_game
signal open_settings
signal open_how_to_play

func _on_StartGame_pressed():
	emit_signal("start_game")
	vary_sounds()
	$Start.playing = true
	
func _on_Settings_pressed():
	emit_signal("open_settings")
	vary_sounds()
	$Start.playing = true

func _on_HowToPlay_pressed():
	emit_signal("open_how_to_play")
	vary_sounds()
	$Start.playing = true
	
func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartGame_mouse_entered():
	vary_sounds()
	$Hover.playing = true

func _on_Settings_mouse_entered():
	vary_sounds()
	$Hover.playing = true

func _on_HowToPlay_mouse_entered():
	vary_sounds()
	$Hover.playing = true

func vary_sounds():
	$Hover.volume_db = rand_range(-10, -7)
	$Hover.pitch_scale = rand_range(1, 1.1)
	$Start.volume_db = rand_range(-7, -5)
	$Start.pitch_scale = rand_range(1, 1.1)
