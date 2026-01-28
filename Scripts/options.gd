extends Node2D

@onready var chip: AudioStreamPlayer2D = $"Back Ground/ChipSound"
@onready var pile: AudioStreamPlayer2D = $"Back Ground/ChipPileSound"
@onready var music: HSlider = $Sliders/Music
@onready var sfx: HSlider = $Sliders/SFX
@onready var pause_back: TextureButton = $PauseBack
@onready var difficulty_button: TextureButton = $"Buttons/Difficulty Button"
@onready var difficulty_label: Label = $"Buttons/Difficulty Button/Difficulty Label"
const GREEN = preload("res://Sprites/Buttons/Green.png")
const GREEN_HOVER = preload("res://Sprites/Buttons/GreenHover.png")
const GREEN_DISABLED = preload("res://Sprites/Buttons/GreenDisabled.png")
const RED = preload("res://Sprites/Buttons/Red.png")
const RED_HOVER = preload("res://Sprites/Buttons/RedHover.png")
const RED_DISABLED = preload("res://Sprites/Buttons/RedDisabled.png")

var difficulty = [["Normal", 100, 1, GREEN, GREEN_HOVER, GREEN_DISABLED], ["Hard", 1, -1, RED, RED_HOVER, RED_DISABLED]]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.value = save.contents_to_save.musicVolume
	sfx.value = save.contents_to_save.sfxVolume
	difficulty_label.text = difficulty[global.difficulty][0]
	global.money = difficulty[global.difficulty][1]
	difficulty_button.texture_normal = difficulty[global.difficulty][3]
	difficulty_button.texture_hover = difficulty[global.difficulty][4]
	difficulty_button.texture_disabled = difficulty[global.difficulty][5]
	difficulty_button.disabled = global.inGame

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") 
	chipSound.play()
	
	
func _on_pause_back_pressed() -> void:
	self.queue_free()
	global.pauseButtons = false
	chipSound.play()


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))
	#global.musicVolume = music.value
	save.contents_to_save.musicVolume = music.value
	save._save()

func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))
	#global.sfxVolume = sfx.value
	save.contents_to_save.sfxVolume = sfx.value
	save._save()
	
func _on_sfx_drag_ended(value_changed: bool) -> void:
	pile.play()
	
	

func _on_texture_button_pressed() -> void:
	global.difficulty += difficulty[global.difficulty][2]
	difficulty_label.text = difficulty[global.difficulty][0]
	global.money = difficulty[global.difficulty][1]
	difficulty_button.texture_normal = difficulty[global.difficulty][3]
	difficulty_button.texture_hover = difficulty[global.difficulty][4]
	difficulty_button.texture_disabled = difficulty[global.difficulty][5]
	chip.play()
	
	save.contents_to_save.difficulty = global.difficulty
	save._save()
	
	difficulty_button.position.y += 3
	await get_tree().create_timer(.1).timeout
	difficulty_button.position.y -= 3
