extends Node

@onready var flip_sound: AudioStreamPlayer2D = $FlipSound
@onready var bridge_sound: AudioStreamPlayer2D = $BridgeSound
@onready var chip_pile_sound: AudioStreamPlayer2D = $ChipPileSound

@onready var standButton: Sprite2D = $Stand
@onready var hitButton: Sprite2D = $Hit

@onready var player_hand_val: Label = $"../Table/playerHandVal"
@onready var dealer_hand_val: Label = $"../Table/dealerHandVal"
@onready var money: Label = $"../Table/Money"


var new_card = preload("res://Scenes/card.tscn")
var new_chip = preload("res://Scenes/chip.tscn")
var bettingScene = preload("res://Scenes/betting.tscn")
var liveDeck = global.deck.keys()
var playerHand = [0, false, 0]
var dealerHand = [0, false, 1]
var isPlayerTurn = false
var isDealerTurn = false
var isBetting = true
var dealerDown
var bettingUI
var cards = []
var chips = []
var chipsWon = []
var blackjackPay = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	standButton.connect("clicked", stand)
	hitButton.connect("clicked", hit)
	global.money = 100
	getBet()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		global.money += 1000
	
	money.text = "$" + str(global.money)
	
	if isBetting:
		dealer_hand_val.text = "Dealer must draw to 16 and stand on 17"
		player_hand_val.text = str(global.bet[6])
		
		if global.dealCards:
			dealCards()
	else:
		
		if playerHand[0] > 21:
			player_hand_val.text = str(playerHand[0]) + ", Bust!"
		elif playerHand[0] == 21 and global.delt[0] == 2:
			player_hand_val.text = "Blackjack!"
		else: 
			player_hand_val.text = str(playerHand[0])
		if dealerHand[0] > 21:
			dealer_hand_val.text = str(dealerHand[0]) + ", Bust!"
		elif dealerHand[0] == 21 and global.delt[1] == 2:
			dealer_hand_val.text = "Blackjack!"
		else: 
			dealer_hand_val.text = str(dealerHand[0])
		
		if isPlayerTurn:
			standButton.visible = true
			hitButton.visible = true
		else:
			standButton.visible = false
			hitButton.visible = false
		
		if Input.is_action_just_pressed("Hit") and isPlayerTurn == true:
			hit()
			
		if (Input.is_action_just_pressed("Stand") or playerHand[0] == 21) and isPlayerTurn == true:
			stand()
			
		if playerHand[0] > 21 and isPlayerTurn == true:
			isPlayerTurn = false
			await get_tree().create_timer(1.2).timeout
			end()
		
		if isDealerTurn == true and dealerDown.scale.x > 0 and dealerDown.value == 0:
			choose_card(dealerDown, dealerHand)

func getBet():
	global.bet = [0, 0, 0, 0, 0, 0, 0]
	global.chips = 0
	isBetting = true
	var instance = bettingScene.instantiate()
	instance.scale = Vector2(3,3)
	instance.position = Vector2(0,250)
	bettingUI = instance
	add_child(instance)
	bettingUI.checkPurple()

func stand():
	isPlayerTurn = false
	if playerHand[0] == 21:
		await get_tree().create_timer(1).timeout
	dealerTurn()
	
func hit():
	deal_card(playerHand, false)

func dealCards():
	bettingUI.queue_free()
	global.dealCards = false
	isBetting = false
	
	dealChips()
	
	deal_card(dealerHand, false)
	await get_tree().create_timer(.2).timeout
	deal_card(playerHand, false)
	await get_tree().create_timer(.2).timeout
	deal_card(dealerHand, true)
	await get_tree().create_timer(.2).timeout
	deal_card(playerHand, false)
	
	await get_tree().create_timer(.5).timeout
	isPlayerTurn = true
	

func dealChips():
	for i in range(6):
		for j in range(global.bet[i]):
			global.chips += 1
			var instance = new_chip.instantiate()
			instance.num = global.chips
			instance.chipTexture = global.chipColors[i]
			
			var winnings = new_chip.instantiate()
			winnings.num = global.chips
			winnings.chipTexture = global.chipColors[i]
			winnings.z_index = -2
			winnings.visible = false
			
			chips.append(instance)
			chipsWon.append(winnings)
			add_child(instance)
			add_child(winnings)

func end():
	isDealerTurn = false
	isPlayerTurn = false
	await get_tree().create_timer(2).timeout
	
	if player_hand_val.text == "Blackjack!":
		if dealer_hand_val.text == "Blackjack!":
			global.money += global.bet[6]
		else:
			chip_pile_sound.play()
			blackjackPay = int(ceil(global.bet[6] * 0.5))
			global.money += global.bet[6] * 2 + blackjackPay
			for i in range(5, -1, -1):
				while blackjackPay >= global.chipValues[i]:
					global.chips += 1
					var winnings = new_chip.instantiate()
					winnings.num = global.chips
					winnings.chipTexture = global.chipColors[i]
					winnings.z_index = -2
					winnings.position = Vector2(-679, -300)
					winnings.visible = false
					
					chipsWon.append(winnings)
					add_child(winnings)
							
					blackjackPay -= global.chipValues[i]
			for chip in chipsWon:
				chip.visible = true
				chip.position = Vector2(-679, -300)
				chip.y = 200
				await get_tree().create_timer(.075).timeout
			
	elif dealerHand[0] > 21 or (playerHand[0] > dealerHand[0] and playerHand[0] < 22):
		chip_pile_sound.play()
		global.money += global.bet[6] * 2
		for chip in chipsWon:
			chip.visible = true
			chip.position = Vector2(-679, -300)
			chip.y = 200
			await get_tree().create_timer(.075).timeout
	elif dealerHand[0] == playerHand[0] and dealer_hand_val.text != "Blackjack!":
		global.money += global.bet[6]
	else:
		chip_pile_sound.play()
		for chip in chipsWon:
			chip.queue_free()
		chipsWon = []
		for i in range(chips.size() - 1, -1, -1):
			chips[i].losing = true
			chips[i].x = -679
			chips[i].y = -300
			await get_tree().create_timer(.075).timeout
	
	await get_tree().create_timer(.5).timeout
	bridge_sound.play()
	for card in cards:
		card.target_position = Vector2(775, 0)
	await get_tree().create_timer(2).timeout
	for card in cards:
		card.queue_free()
	for chip in chips:
		chip.queue_free()
	for chip in chipsWon:
		chip.queue_free()
	global.delt = [0,0]
	global.end = [250, 250]
	cards = []
	chips = []
	chipsWon = []
	liveDeck = global.deck.keys()
	playerHand = [0, false, 0]
	dealerHand = [0, false, 1]
	blackjackPay = 0
	getBet()

func dealerTurn():
	isPlayerTurn = false
	isDealerTurn = true
	dealerDown.scale.x = -3
	flip_sound.play()
	await get_tree().create_timer(1.2).timeout
	while dealerHand[0] < 17 and not (player_hand_val.text == "Blackjack!" and global.delt[1] > 1):
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
