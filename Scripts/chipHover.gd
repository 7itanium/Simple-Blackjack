extends Area2D

@onready var highlight: Sprite2D = $".."


func _ready():
	mouse_entered.connect(func():
		if not global.paused:
			highlight.modulate.a = .25
	)
	mouse_exited.connect(func():
		highlight.modulate.a = .01
	)
