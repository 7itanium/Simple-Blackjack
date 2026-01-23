extends Node2D

@onready var whiteUp: Sprite2D = $Down/White
@onready var redUp: Sprite2D = $Down/Red
@onready var greenUp: Sprite2D = $Down/Green
@onready var blueUp: Sprite2D = $Down/Blue
@onready var blackUp: Sprite2D = $Down/Black
@onready var whiteDown: Sprite2D = $Up/White
@onready var redDown: Sprite2D = $Up/Red
@onready var greenDown: Sprite2D = $Up/Green
@onready var blueDown: Sprite2D = $Up/Blue
@onready var blackDown: Sprite2D = $Up/Black

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chips = [whiteUp, whiteDown, redUp, redDown, greenUp, greenDown, blueUp, blueDown, blackUp, blackDown]
	var direction = -1
	var val = 0
	for chip in chips:
		chip.direction = direction
		chip.chip = val
		
		direction *= -1
		if direction == -1:
			val += 1
