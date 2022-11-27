extends Node2D

var wave_speed = 0.005
var active = false
var ind = 0
var rate = 3

var waves
func _ready():
	waves = [$Sprite1, $Sprite2, $Sprite3, $Sprite4, $Sprite5, $Sprite6, $Sprite7, $Sprite8, $Sprite9]

func _process(delta):
	if active and not $Timer.time_left:
		$Timer.wait_time = 0.5 / wave_speed * delta / rate
		$Timer.start()
		waves[ind].texture.fill_to.y = 0.99
		waves[ind].wave_speed = wave_speed
		ind += 1
		if ind > 8:
			ind = 0
