extends Node

@onready var flip_sound: AudioStreamPlayer2D = $FlipSound

var new_card = preload("res://Scenes/card.tscn")
var liveDeck = global.deck.keys()
var playerHand = [0, false]
var dealerHand = [0, false]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Hit"):
		global.end += global.step
		global.delt += 1
		var instance = new_card.instantiate()
		instance.num = global.delt
		instance.target_position = Vector2(300, 300)
		choose_card(instance, playerHand)
		add_child(instance)
		flip_sound.play()

func choose_card(card, hand):
	var cardKey = liveDeck[randi() % liveDeck.size()]
	var cardID = global.deck[cardKey]
	card.value = cardID[0]
	card.cardTexture = cardID[1]
	liveDeck.erase(cardKey)
	hand_value(hand, card.value)
	
func hand_value(hand, new):
	hand[0] += new
	if new == 1 and hand[0] < 12:
		hand[0] += 10
		hand[1] = true
	elif hand[0] > 21 and hand[1] == true:
		hand[0] -= 10
		hand[1] = false
