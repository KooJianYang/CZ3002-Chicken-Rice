extends Control

#onready var deckNode = $Deck
var availableDeck = ["T", "S", "C", "CS", "ST", "TC", "CST", "CTS", "STC", "TCS"] #additional: "SCT", "TSC"
var deck = Array()
var difficulty_levels = [3, 6, 10]
var difficulty = GlobalScript.MemoryGameDifficulty
var card1
var card2
var score = 0
var flipDelay = Timer.new()
var Clock = Timer.new()
var seconds = 0
var moves = 0
var start_epoch
var current_epoch
var time_elapsed

onready var stats = $Statistics
onready var movesLabel = $Statistics/Sections/MovesSection/Moves
onready var timerLabel = $Statistics/Sections/TimerSection/Timer
onready var deckGrid = $Deck
onready var end = $GameEnd
onready var timeTaken = $GameEnd/GameEndContainer/TimeTaken
onready var movesTaken = $GameEnd/GameEndContainer/MovesTaken


func _ready():
	fillDeck(difficulty_levels[difficulty])
	dealDeck(difficulty)
	setUpHUD()

func _process(_delta):
	current_epoch = OS.get_ticks_msec()
	time_elapsed = floor((current_epoch-start_epoch)/1000)
	timerLabel.text = str(time_elapsed)
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/MemoryGame/MemoryGameInstructionPage.tscn")

func setUpHUD():
	start_epoch = OS.get_ticks_msec()
	timerLabel.text = str(seconds)
	movesLabel.text = str(moves)

func fillDeck(var difficulty):
	for i in range(difficulty):
		deck.append(Card.new(availableDeck[i]))
		deck.append(Card.new(availableDeck[i]))

func dealDeck(var difficulty):
	if difficulty == 0:
		deckGrid.set_columns(3)
	elif difficulty == 1:
		deckGrid.set_columns(4) 
	elif difficulty == 2:
		deckGrid.set_columns(5)
	
	randomize()
	deck.shuffle()
	for i in deck:
		deckGrid.add_child(i)

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
		moves += 1
		movesLabel.text = str(moves)

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
			endGame()
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

func endGame():
	timeTaken.text = str(time_elapsed) + "seconds"
	movesTaken.text = str(moves)
	
	deckGrid.visible = false
	stats.visible = false
	end.visible = true

