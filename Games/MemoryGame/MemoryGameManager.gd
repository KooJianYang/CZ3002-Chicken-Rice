extends Node

onready var Game = get_node("/root/MemoryGame/")
var availableDeck = ["T", "S", "C", "CS", "ST", "TC", "CST", "CTS", "STC", "TCS"] #additional: "SCT", "TSC"
var deck = Array()
var difficulty_levels = [3, 6, 10]
#3 -> 3, 6 -> 4, 10 -> 5
var cardBack = preload("res://Assets/MemoryGame/Back.png")

var card1
var card2
var score = 0

var difficulty = 1 #placeholder

var flipDelay = Timer.new()

func _ready():
	fillDeck(difficulty_levels[difficulty])
	dealDeck(difficulty)

func fillDeck(var difficulty):
	for i in range(difficulty):
		deck.append(Card.new(availableDeck[i]))
		deck.append(Card.new(availableDeck[i]))

func dealDeck(var difficulty):
	if difficulty == 0:
		Game.get_node("grid").set_columns(3)
	elif difficulty == 1:
		Game.get_node("grid").set_columns(4)
	elif difficulty == 2:
		Game.get_node("grid").set_columns(5)
	
#	deck.shuffle()
	for i in deck:
		Game.get_node("grid").add_child(i)

func chooseCard(var c):
	if card1 == null:
		card1 = c
		card1.flip()
		card1.set_disabled(true)
	elif card2 == null:
		card2 = c
		card2.flip()
		card2.set_disabled(true)
		checkCards()

func checkCards():
	
	flipDelay.set_wait_time(0.5)
	flipDelay.set_one_shot(true)
	self.add_child(flipDelay)
	flipDelay.start()
	yield(flipDelay, "timeout")
	
	if card1.value == card2.value:
		card1.set_modulate(Color(0.5,1,0.5,0.5))
		card2.set_modulate(Color(0.5,1,0.5,0.5))
		card1 = null
		card2 = null
		score += 1
		if score == difficulty_levels[difficulty]:
#			endGame()
			print("Game Ends")
			pass
	else:
		card1.set_modulate(Color(1,0.5,0.5,0.5))
		card2.set_modulate(Color(1,0.5,0.5,0.5))
		
		flipDelay.set_wait_time(1.5)
		flipDelay.set_one_shot(true)
		self.add_child(flipDelay)
		flipDelay.start()
		yield(flipDelay, "timeout")
		
		card1.set_modulate(Color(1,1,1,1))
		card2.set_modulate(Color(1,1,1,1))
		card1.flip()
		card2.flip()
		card1.set_disabled(false)
		card2.set_disabled(false)
		card1 = null
		card2 = null
			
