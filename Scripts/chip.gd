extends Sprite2D

@onready var display: Node2D = $"../.."

@onready var felt_add: AudioStreamPlayer2D = $"../../FeltAdd"
@onready var felt_remove: AudioStreamPlayer2D = $"../../FeltRemove"
@onready var chip_add: AudioStreamPlayer2D = $"../../ChipAdd"
@onready var chip_remove: AudioStreamPlayer2D = $"../../ChipRemove"


var color = 0
var direction = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()) and modulate.a == 1:
				global.bet[color] += direction
				if global.bet[color] < 0:
					global.bet[color] = 0
				elif global.bet[color] > 10:
					global.bet[color] = 10
				else:
					global.money += display.values[color] * direction * -1
					global.bet[5] = (global.bet[0] * display.values[0]) + (global.bet[1] * display.values[1]) + (global.bet[2] * display.values[2]) + (global.bet[3] * display.values[3]) + (global.bet[4] * display.values[4])
					
					if direction == 1:
						if global.bet[color] == 1:
							felt_add.play()
						else:
							chip_add.play()
					else:
						if global.bet[color] == 0:
							felt_remove.play()
						else:
							chip_remove.play()	
					
					if direction == 1:
						display.displayChips[color][global.bet[color] - 1].visible = true
					else:
						display.displayChips[color][global.bet[color]].visible = false
				
				display.checkBal()
