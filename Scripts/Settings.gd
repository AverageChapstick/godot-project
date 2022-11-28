extends Control

signal return_pressed
signal toggled_shake
signal toggled_glow
signal set_sound

func _on_ScreenShake_pressed():
	emit_signal("toggled_shake")
	vary_sounds()
	$Start.playing = true

func _on_Glow_pressed():
	emit_signal("toggled_glow")
	vary_sounds()
	$Start.playing = true

func _on_ReturnButton_pressed():
	emit_signal("return_pressed")
	vary_sounds()
	$Start.playing = true

func _on_ScreenShake_mouse_entered():
	vary_sounds()
	$Hover.playing = true
	$Tween.interpolate_property($GridContainer/ScreenShake, "rect_scale", $GridContainer/ScreenShake.rect_scale, Vector2(1.1, 1.1), 0.1)
	$Tween.start()

func _on_Glow_mouse_entered():
	vary_sounds()
	$Hover.playing = true
	$Tween.interpolate_property($GridContainer/Glow, "rect_scale", $GridContainer/Glow.rect_scale, Vector2(1.1, 1.1), 0.1)
	$Tween.start()

func _on_ReturnButton_mouse_entered():
	vary_sounds()
	$Hover.playing = true
	$Tween.interpolate_property($ReturnButton, "rect_scale", $ReturnButton.rect_scale, Vector2(1.6, 1.6), 0.1)
	$Tween.start()

func _on_ScreenShake_mouse_exited():
	$Tween.interpolate_property($GridContainer/ScreenShake, "rect_scale", $GridContainer/ScreenShake.rect_scale, Vector2(1, 1), 0.1)
	$Tween.start()

func _on_Glow_mouse_exited():
	$Tween.interpolate_property($GridContainer/Glow, "rect_scale", $GridContainer/Glow.rect_scale, Vector2(1, 1), 0.1)
	$Tween.start()

func _on_ReturnButton_mouse_exited():
	$Tween.interpolate_property($ReturnButton, "rect_scale", $ReturnButton.rect_scale, Vector2(1.5, 1.5), 0.1)
	$Tween.start()

func _on_HSlider_drag_started():
	vary_sounds()
	$Start.playing = true

func _on_HSlider_mouse_entered():
	vary_sounds()
	$Hover.playing = true
	$Tween.interpolate_property($GridContainer/HSlider, "rect_scale", $GridContainer/HSlider.rect_scale, Vector2(1.1, 1.1), 0.1)
	$Tween.start()

func _on_HSlider_mouse_exited():
	$Tween.interpolate_property($GridContainer/HSlider, "rect_scale", $GridContainer/ScreenShake.rect_scale, Vector2(1, 1), 0.1)
	$Tween.start()

func _on_HSlider_value_changed(value):
	$GridContainer/VolumeLabel.text = "Sound Fx Volume      " + str(value) + "%"
	emit_signal("set_sound", value)

func vary_sounds():
	$Hover.volume_db = rand_range(-10, -7)
	$Hover.pitch_scale = rand_range(1, 1.1)
	$Start.volume_db = rand_range(-7, -5)
	$Start.pitch_scale = rand_range(1, 1.1)

