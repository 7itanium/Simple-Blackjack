extends Node2D

@onready var chip: AudioStreamPlayer2D = $Chip
@onready var pile: AudioStreamPlayer2D = $"Back Ground/ChipPileSound"
@onready var music: HSlider = $Sliders/Music
@onready var sfx: HSlider = $Sliders/SFX
@onready var pause_back: TextureButton = $PauseBack



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.value = global.musicVolume
	sfx.value = global.sfxVolume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") 
	
	
func _on_pause_back_pressed() -> void:
	self.queue_free()
	global.pauseButtons = false


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))
	global.musicVolume = music.value

func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))
	global.sfxVolume = sfx.value


func _on_sfx_drag_ended(value_changed: bool) -> void:
	pile.play()
