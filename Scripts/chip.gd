extends Sprite2D

var chip = 0
var direction = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()):
				global.bet[chip] += direction
				if global.bet[chip] < 0:
					global.bet[chip] = 0
				print(global.bet)
