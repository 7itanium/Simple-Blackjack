extends Sprite2D

var chipTexture = "res://Sprites/Chips/Check.png"

var target_position = Vector2(0, 0)
var num = 0
var x
var y = 300
const SPEED = 5.0 
var losing = false

func _ready() -> void:
	position = Vector2(-470, 300)
	texture = load(chipTexture)

func _process(delta: float) -> void:
	if not losing:
		x = (-825 + ((250 / (global.chips + 1)) * num))
	target_position = Vector2(x, y)
	
	if position != target_position:
		position.x = lerp(position.x, target_position.x, SPEED * delta)
		position.y = lerp(position.y, target_position.y, SPEED * delta)
	
		if position.distance_to(target_position) < 1:
			position = target_position
