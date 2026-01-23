extends Node

@onready var flip_sound: AudioStreamPlayer2D = $FlipSound
@onready var player_hand_val: Label = $"../Table/playerHandVal"
@onready var dealer_hand_val: Label = $"../Table/dealerHandVal"
@onready var bridge_sound: AudioStreamPlayer2D = $BridgeSound

var new_card = preload("res://Scenes/card.tscn")
var liveDeck = global.deck.keys()
var playerHand = [0, false, 0]
var dealerHand = [0, false, 1]
var isPlayerTurn = false
var isDealerTurn = false
var dealerDown
var cards = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		global.delt = [0,0]
		global.end = [250, 250]
		cards = []
		get_tree().reload_current_scene()
	
	
	if playerHand[0] > 21:
		player_hand_val.text = str(playerHand[0]) + ", Bust!"
	else: 
		player_hand_val.text = str(playerHand[0])
	if dealerHand[0] > 21:
		dealer_hand_val.text = str(dealerHand[0]) + ", Bust!"
	else: 
		dealer_hand_val.text = str(dealerHand[0])
	
	
	if Input.is_action_just_pressed("Hit") and isPlayerTurn == true:
		deal_card(playerHand, false)
		
	if Input.is_action_just_pressed("Stand") and isPlayerTurn == true:
		dealerTurn()
		
	if playerHand[0] > 21 and isPlayerTurn == true:
		isPlayerTurn = false
		await get_tree().create_timer(1.2).timeout
		end()
	
	if isDealerTurn == true and dealerDown.scale.x > 0 and dealerDown.value == 0:
		choose_card(dealerDown, dealerHand)

func start():
	deal_card(dealerHand, false)
	await get_tree().create_timer(.2).timeout
	deal_card(playerHand, false)
	await get_tree().create_timer(.2).timeout
	deal_card(dealerHand, true)
	await get_tree().create_timer(.2).timeout
	deal_card(playerHand, false)
	await get_tree().create_timer(.5).timeout
	isPlayerTurn = true
	
func end():
	isDealerTurn = false
	isPlayerTurn = false
	await get_tree().create_timer(2).timeout
	bridge_sound.play()
	for card in cards:
		card.target_position = Vector2(775, 0)
	await get_tree().create_timer(2).timeout
	for card in cards:
		card.queue_free()
	global.delt = [0,0]
	global.end = [250, 250]
	cards = []
	liveDeck = global.deck.keys()
	playerHand = [0, false, 0]
	dealerHand = [0, false, 1]
	start()

func dealerTurn():
	isPlayerTurn = false
	isDealerTurn = true
	dealerDown.scale.x = -3
	flip_sound.play()
	await get_tree().create_timer(1.2).timeout
	while dealerHand[0] < 17:
		deal_card(dealerHand, false)
		await get_tree().create_timer(1.2).timeout
	end()

func deal_card(hand,down):
	global.end[hand[2]] += global.STEP
	global.delt[hand[2]] += 1
	var instance = new_card.instantiate()
	instance.isDealer = hand[2]
	instance.num = global.delt[hand[2]]
	instance.target_position = Vector2(300, 300)
	if down == false:
		choose_card(instance, hand)
	else:
		dealerDown = instance
	cards.append(instance)
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
