extends Sprite2D

signal clicked

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()) and visible == true:
				emit_signal("clicked")
				position.y += 3
				await get_tree().create_timer(.1).timeout
				position.y -= 3
