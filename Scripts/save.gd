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
	global.most_money = contents_to_save.most_money.duplicate()
	global.all_money = contents_to_save.all_money.duplicate()
	global.most_earnings = contents_to_save.most_earnings.duplicate()
	global.fullscreen = contents_to_save.fullscreen

	if !global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(global.musicVolume)
	)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(global.sfxVolume)
	)


func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_string(JSON.stringify(contents_to_save))
	file.close()

	
func _load():
	if !FileAccess.file_exists(save_location):
		return

	var file = FileAccess.open(save_location, FileAccess.READ)
	var text = file.get_as_text()
	file.close()

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		print("Save file corrupted, using defaults")
		return

	contents_to_save.musicVolume = float(data.get("musicVolume", 1.5))
	contents_to_save.sfxVolume = float(data.get("sfxVolume", 1.5))
	contents_to_save.difficulty = int(data.get("difficulty", 0))
	contents_to_save.fullscreen = bool(data.get("fullscreen", true))

	contents_to_save.most_money = data.get("most_money", [100, 1]) \
		.map(func(v): return int(v))
	contents_to_save.all_money = data.get("all_money", [0, 0]) \
		.map(func(v): return int(v))
	contents_to_save.most_earnings = data.get("most_earnings", [0, 0]) \
		.map(func(v): return int(v))
