extends Node2D

@onready var flip_sound: AudioStreamPlayer2D = $FlipSound
@onready var game_manager: Node = %"Game Manager"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	game_manager.unpause()
	theme.seek(0)
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") 


func _on_return_pressed() -> void:
	game_manager.unpause()


func _on_return_mouse_entered() -> void:
	flip_sound.play()


func _on_return_mouse_exited() -> void:
	flip_sound.play()


func _on_quit_mouse_entered() -> void:
	flip_sound.play()


func _on_quit_mouse_exited() -> void:
	flip_sound.play()
