extends Control

signal return_pressed

func _ready():
	$PushWave.active = true
	$PushWave.wave_speed = 0.003
	$PullWave.active = true

func _on_ReturnButton_pressed():
	emit_signal("return_pressed")
	vary_sounds()
	$Start.playing = true

func _on_ReturnButton_mouse_entered():
	vary_sounds()
	$Hover.playing = true
	$Tween.interpolate_property($ReturnButton, "rect_scale", $ReturnButton.rect_scale, Vector2(1.6, 1.6), 0.1)
	$Tween.start()

func _on_ReturnButton_mouse_exited():
	$Tween.interpolate_property($ReturnButton, "rect_scale", $ReturnButton.rect_scale, Vector2(1.5, 1.5), 0.1)
	$Tween.start()

func vary_sounds():
	$Hover.volume_db = rand_range(-10, -7)
	$Hover.pitch_scale = rand_range(1, 1.1)
	$Start.volume_db = rand_range(-7, -5)
	$Start.pitch_scale = rand_range(1, 1.1)
