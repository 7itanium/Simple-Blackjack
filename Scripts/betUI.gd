extends Node2D

@onready var chips = [$Up/White, $Down/White, $Up/Red, $Down/Red, $Up/Green, $Down/Green, $Up/Blue, $Down/Blue, $Up/Black, $Down/Black, $Up/Purple, $Down/Purple]

@onready var whiteChips = [$WhiteStack/White, $WhiteStack/White2, $WhiteStack/White3, $WhiteStack/White4, $WhiteStack/White5, $WhiteStack/White6, $WhiteStack/White7, $WhiteStack/White8, $WhiteStack/White9, $WhiteStack/White10]
@onready var redChips = [$RedStack/Red, $RedStack/Red2, $RedStack/Red3, $RedStack/Red4, $RedStack/Red5, $RedStack/Red6, $RedStack/Red7, $RedStack/Red8, $RedStack/Red9, $RedStack/Red10]
@onready var greenChips = [$"Green Stack/Green", $"Green Stack/Green2", $"Green Stack/Green3", $"Green Stack/Green4", $"Green Stack/Green5", $"Green Stack/Green6", $"Green Stack/Green7", $"Green Stack/Green8", $"Green Stack/Green9", $"Green Stack/Green10"]
@onready var blueChips = [$"Blue Stack/Blue", $"Blue Stack/Blue2", $"Blue Stack/Blue3", $"Blue Stack/Blue4", $"Blue Stack/Blue5", $"Blue Stack/Blue6", $"Blue Stack/Blue7", $"Blue Stack/Blue8", $"Blue Stack/Blue9", $"Blue Stack/Blue10"]
@onready var blackChips = [$"Black Stack/Black", $"Black Stack/Black2", $"Black Stack/Black3", $"Black Stack/Black4", $"Black Stack/Black5", $"Black Stack/Black6", $"Black Stack/Black7", $"Black Stack/Black8", $"Black Stack/Black9", $"Black Stack/Black10"]
@onready var purpleChips = [$"Purple Stack/Purple", $"Purple Stack/Purple2", $"Purple Stack/Purple3", $"Purple Stack/Purple4", $"Purple Stack/Purple5", $"Purple Stack/Purple6", $"Purple Stack/Purple7", $"Purple Stack/Purple8", $"Purple Stack/Purple9", $"Purple Stack/Purple10"]

@onready var displayChips = [whiteChips, redChips, greenChips, blueChips, blackChips, purpleChips]

@onready var check: Sprite2D = $Check

@onready var values = global.chipValues


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var direction = 1
	var val = 0
	for chip in chips:
		chip.direction = direction
		chip.color = val
		
		direction *= -1
		if direction == 1:
			val += 1
	checkBal()

func checkPurple():
	if global.money >= 1000:
		check.position.x = 235
		chips[10].position.x = 200
		chips[11].position.x = 200
	else:
		check.position.x = 200
		chips[10].position.x = 2000
		chips[11].position.x = 2000

func checkBal():
	if global.bet[6] == 0:
		check.modulate.a = 0.5
	else:
		check.modulate.a = 1
		
	if global.money < values[0]:
		chips[0].modulate.a = 0.5
	else:
		chips[0].modulate.a = 1
		
	if global.money < values[1]:
		chips[2].modulate.a = 0.5
	else:
		chips[2].modulate.a = 1
		
	if global.money < values[2]:
		chips[4].modulate.a = 0.5
	else:
		chips[4].modulate.a = 1
		
	if global.money < values[3]:
		chips[6].modulate.a = 0.5
	else:
		chips[6].modulate.a = 1
		
	if global.money < values[4]:
		chips[8].modulate.a = 0.5
	else:
		chips[8].modulate.a = 1
	
	if global.money < values[5]:
		chips[10].modulate.a = 0.5
	else:
		chips[10].modulate.a = 1
