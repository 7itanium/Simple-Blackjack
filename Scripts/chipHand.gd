extends Sprite2D

var chipTexture = "res://Sprites/Chips/White.png"

var target_position = Vector2(0, 0)
var num
var x
const SPEED = 5.0 

func _process(delta: float) -> void:
	texture = load(chipTexture)
	
	x = 0
	target_position = Vector2(x, 300)
	
	if position != target_position:
		position.x = lerp(position.x, target_position.x, SPEED * delta)
		position.y = lerp(position.y, target_position.y, SPEED * delta)
	
		if position.distance_to(target_position) < 1:
			position = target_position
