extends Node

const save_location = "user://SimpleBlackjackSave.json"

var contents_to_save: Dictionary = {
	"musicVolume": 1.5,
	"sfxVolume": 1.5,
	"difficulty": 0,
	"most_money": [100,1],
	"all_money": [0,0],
	"most_earnings": [0,0],
	"fullscreen": true
}

func _ready() -> void:
	_load()
	global.musicVolume = contents_to_save.musicVolume
	global.sfxVolume = contents_to_save.sfxVolume
	global.difficulty = contents_to_save.difficulty
	global.most_money = contents_to_save.most_money
	global.all_money = contents_to_save.all_money
	global.most_earnings = contents_to_save.most_earnings
	global.fullscreen = contents_to_save.fullscreen
	if !global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(save.contents_to_save.musicVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(save.contents_to_save.sfxVolume))

func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()
	
func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		contents_to_save.musicVolume = save_data.musicVolume
		contents_to_save.sfxVolume = save_data.sfxVolume
		contents_to_save.difficulty = save_data.difficulty
		contents_to_save.most_money = save_data.most_money
		contents_to_save.all_money = save_data.all_money
		contents_to_save.most_earnings = save_data.most_earnings
		contents_to_save.fullscreen = save_data.fullscreen
