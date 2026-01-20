extends Sprite2D

@onready var sprite: Sprite2D = $Sprite2D

var target_position = Vector2(775, -300)
var x
const SPEED = 5.0 
var num = 0
var value
var suit
var cardTexture = "res://Sprites/Cards/back.png"

#@onready var game_manager: Node = %"Game Manager"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(775, -300)



# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	texture = load(cardTexture)
	x = (-global.end+(((global.end * 2)/(global.delt+1))*num))
	#target_position = Vector2(x, 300 + 10 * ((num + 1) % 2) )
	target_position = Vector2(x, 300)
	
	if position != target_position:
		position.x = lerp(position.x, target_position.x, SPEED * delta)
		position.y = lerp(position.y, target_position.y, SPEED * delta)
	
	if position.distance_to(target_position) < 1:
		position = target_position
