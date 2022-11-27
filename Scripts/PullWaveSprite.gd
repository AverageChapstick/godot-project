extends Sprite

var wave_speed

func _ready():
	texture = texture.duplicate()

func _process(_delta):
	if texture.fill_to.y <= 0.5:
		texture.fill_to.y = 1
		modulate = Color(1, 1, 1, 0)
	if not texture.fill_to.y == 1:
		texture.fill_to.y -= wave_speed
		print(1 - texture.fill_to.y)
		modulate += Color(0, 0, 0, wave_speed * 3)
		yield(get_tree().create_timer(wave_speed), "timeout")
		texture.set_flags(7)
		texture.set_flags(1)
