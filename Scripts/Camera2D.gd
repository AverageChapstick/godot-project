extends Camera2D

func _on_Node_big_screenshake():
	$Screenshake.start(0.1, 20, 5)

func _on_Node_small_screenshake():
	$Screenshake.start(0.1, 20, 2)
