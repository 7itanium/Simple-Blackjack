extends Node2D

@onready var flip_sound: AudioStreamPlayer2D = $FlipSound
@onready var game_manager: Node = %"Game Manager"
var optionsScene = preload("res://Scenes/options.tscn")
var optionsRefrence
var inOptions = false

@onready var quit: TextureButton = $"Button Manager/Quit"
@onready var settings: TextureButton = $"Button Manager/Settings"
@onready var resume: TextureButton = $"Button Manager/Return"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	quit.disabled = global.pauseButtons
	settings.disabled = global.pauseButtons
	resume.disabled = global.pauseButtons

func _on_quit_pressed() -> void:
	game_manager.unpause()
	theme.seek(0)
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") 


func _on_settings_pressed() -> void:
	global.pauseButtons = true
	var instance = optionsScene.instantiate()
	optionsRefrence = instance
	add_child(instance)
	optionsRefrence.pause_back.position = Vector2(-864, 353)
	

func _on_return_pressed() -> void:
	game_manager.unpause()

func playFlip():
	if not global.pauseButtons:
		flip_sound.play()

func _on_return_mouse_entered() -> void:
	playFlip()


func _on_return_mouse_exited() -> void:
	playFlip()

func _on_settings_mouse_entered() -> void:
	playFlip()


func _on_settings_mouse_exited() -> void:
	playFlip()


func _on_quit_mouse_entered() -> void:
	playFlip()


func _on_quit_mouse_exited() -> void:
	playFlip()
