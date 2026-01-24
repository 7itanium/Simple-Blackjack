extends Sprite2D

signal pressed

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()) and modulate.a == 1:
				global.dealCards = true
