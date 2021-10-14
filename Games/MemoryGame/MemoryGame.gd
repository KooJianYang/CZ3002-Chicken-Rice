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
var document_task : FirestoreTask 
var document: FirestoreDocument 
var firestore_collection : FirestoreCollection
var firestore_collection2 : FirestoreCollection
var currentTime
var player_email

onready var http : HTTPRequest = $HTTPRequest
onready var stats = $Statistics
onready var movesLabel = $Statistics/Sections/MovesSection/Moves
onready var timerLabel = $Statistics/Sections/TimerSection/Timer
onready var deckGrid = $Deck
onready var end = $GameEnd
onready var timeTaken = $GameEnd/GameEndContainer/TimeTaken
onready var movesTaken = $GameEnd/GameEndContainer/MovesTaken


func _ready():
	player_email = GlobalScript.email
	var systime = OS.get_datetime()
	var day = systime["day"]
	var month = systime["month"]
	var year = systime["year"]
	var hour = systime["hour"]
	var minute = systime["minute"]
	var sec = systime["second"]
	currentTime = (str(day)+"/"+str(month)+"/"+str(year)+","+str(hour)+":"+str(minute)+":"+str(sec))
	#e.g. 12/10/21 14:13:45
	
	player_email = GlobalScript.email
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/MScore")
	fillDeck(difficulty_levels[difficulty])
	dealDeck(difficulty)
	setUpHUD()
	if difficulty == 0:
		document_task = firestore_collection.get("Easy")
	elif difficulty == 1:
		document_task = firestore_collection.get("Normal")
	elif difficulty == 2:
		document_task = firestore_collection.get("Hard")
	document= yield(document_task, "get_document")

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
	var noOfTimesPlayed = (document.doc_fields.get('NoOfTimesPlayed'))
	timeTaken.text = str(time_elapsed) + " Seconds"
	movesTaken.text = str(moves) + " Moves"
	#var MScore = str(document.doc_fields.get('MScore0'))
	var index = 1
	var MScore = str(document.doc_fields.get('HighScore'))
	var currentScore = str(time_elapsed)
	if difficulty == 0 or null:
		if int(currentScore) < int(MScore): 
			firestore_collection.update("Easy",{'HighScore': currentScore})
		elif int(currentScore) > int(MScore): 
			firestore_collection.update("Easy",{'HighScore': MScore})
		noOfTimesPlayed += 1
		if noOfTimesPlayed == 1:
			firestore_collection.update("Easy",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
		firestore_collection.update("Easy",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
		if noOfTimesPlayed > 1:
			var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
			firestore_collection.update("Easy",{'SumScore': int(sumScore)})
			var avgScore = floor(sumScore / noOfTimesPlayed)
			firestore_collection.update("Easy",{'AvgScore': int(avgScore)})
	elif difficulty == 1:
		if int(currentScore) < int(MScore): 
			firestore_collection.update("Normal",{'HighScore': currentScore})
		elif int(currentScore) > int(MScore): 
			firestore_collection.update("Normal",{'HighScore': MScore})
		noOfTimesPlayed += 1
		if noOfTimesPlayed == 1:
			firestore_collection.update("Normal",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
		firestore_collection.update("Normal",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
		if noOfTimesPlayed > 1:
			var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
			firestore_collection.update("Normal",{'SumScore': int(sumScore)})
			var avgScore = floor(sumScore / noOfTimesPlayed)
			firestore_collection.update("Normal",{'AvgScore': int(avgScore)})
	elif difficulty == 2:
		if int(currentScore) < int(MScore): 
			firestore_collection.update("Hard",{'HighScore': currentScore})
		elif int(currentScore) > int(MScore): 
			firestore_collection.update("Hard",{'HighScore': MScore})
		noOfTimesPlayed += 1
		if noOfTimesPlayed == 1:
			firestore_collection.update("Hard",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
		firestore_collection.update("Hard",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
		if noOfTimesPlayed > 1:
			var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
			firestore_collection.update("Hard",{'SumScore': int(sumScore)})
			var avgScore = floor(sumScore / noOfTimesPlayed)
			firestore_collection.update("Hard",{'AvgScore': int(avgScore)})

	MScore = ""
	currentScore = ""
	
	#Player's Total Average Score accross All Difficulty Levels		
	firestore_collection2  = Firebase.Firestore.collection("userdata/"+player_email+"/MScore")
	yield(get_tree().create_timer(0.5),"timeout")
	document_task = firestore_collection2.get("Easy")
	document= yield(document_task, "get_document")
	var getEasySumScore = (document.doc_fields.get('SumScore'))
	var getEasyNoOfPlays = (document.doc_fields.get('NoOfTimesPlayed'))
	print(getEasySumScore)
	print(getEasyNoOfPlays)
	
	document_task = firestore_collection2.get("Normal")
	document= yield(document_task, "get_document")
	var getNormalSumScore = (document.doc_fields.get('SumScore'))
	var getNormalNoOfPlays = (document.doc_fields.get('NoOfTimesPlayed'))
	print(getNormalSumScore)
	print(getNormalNoOfPlays)

	document_task = firestore_collection2.get("Hard")
	document= yield(document_task, "get_document")
	var getHardSumScore = (document.doc_fields.get('SumScore'))
	var getHardNoOfPlays = (document.doc_fields.get('NoOfTimesPlayed'))
	print(getHardSumScore)
	print(getHardNoOfPlays)
	
	var totalScores = getEasySumScore + getNormalSumScore + getHardSumScore
	var totalNoOfPlays = getEasyNoOfPlays + getNormalNoOfPlays + getHardNoOfPlays
	var totalAvg = totalScores / totalNoOfPlays
	firestore_collection2.update("AvgScore",{'AvgScore': totalAvg, 'NoOfTimesPlayed': totalNoOfPlays, 'SumScore': totalScores})
	
	deckGrid.visible = false
	stats.visible = false
	end.visible = true
	

