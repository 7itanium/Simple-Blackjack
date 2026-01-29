extends Node2D

@onready var flip_sound: AudioStreamPlayer2D = $FlipSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/table.tscn") 


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn") 
	flipSound.play()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_mouse_entered() -> void:
	flip_sound.play()


func _on_settings_mouse_entered() -> void:
	flip_sound.play()


func _on_quit_mouse_entered() -> void:
	flip_sound.play()


func _on_start_mouse_exited() -> void:
	flip_sound.play()


func _on_settings_mouse_exited() -> void:
	flip_sound.play()


func _on_quit_mouse_exited() -> void:
	flip_sound.play()
