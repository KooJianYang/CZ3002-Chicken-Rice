extends Control

onready var circles_manager = $CirclesManager
onready var countdown_label = $CountdownLabel
onready var game_end = $GameEnd
onready var timer = $Timer
var difficulty = GlobalScript.ObservationGameDifficulty
var circles_to_spawn_based_on_difficulty = [8, 16, 25]
var seconds_elapsed_in_game : int = 0

var document_task : FirestoreTask 
var document: FirestoreDocument 
var firestore_collection : FirestoreCollection
var firestore_collection2 : FirestoreCollection
var currentTime
var player_email

func _ready() -> void:
	set_up_game_based_on_difficulty(difficulty)
	circles_manager.connect("connected_all_circles", self, "end_game")
	countdown_label.connect("finished_countdown", self, "start_game")
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
	
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/OScore")
	if difficulty == 0 or null:
		document_task = firestore_collection.get("Easy")
	elif difficulty == 1:
		document_task = firestore_collection.get("Normal")
	elif difficulty == 2:
		document_task = firestore_collection.get("Hard")
	document= yield(document_task, "get_document")

func set_up_game_based_on_difficulty(difficulty : int) -> void:
	var number_of_circles_to_spawn : int = circles_to_spawn_based_on_difficulty[difficulty]
	circles_manager.spawn_circles(number_of_circles_to_spawn)
	circles_manager.last_circle_to_connect = number_of_circles_to_spawn


func end_game() -> void:
	game_end.visible = true
	hide_circles()
	timer.stop()
	game_end.get_node("GameEndContainer").get_node("TimeTakenLabel").update_time_taken_label(seconds_elapsed_in_game)
	var noOfTimesPlayed = (document.doc_fields.get('NoOfTimesPlayed'))
	#data start
	var index = 1
	var OScore = str(document.doc_fields.get('HighScore'))
	var currentScore = str(round(seconds_elapsed_in_game))
	if difficulty == 0 or null:
		if int(currentScore) < int(OScore): 
			firestore_collection.update("Easy",{'HighScore': currentScore})
		elif int(currentScore) > int(OScore): 
			firestore_collection.update("Easy",{'HighScore': OScore})
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
		if int(currentScore) < int(OScore): 
			firestore_collection.update("Normal",{'HighScore': currentScore})
		elif int(currentScore) > int(OScore): 
			firestore_collection.update("Normal",{'HighScore': OScore})
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
		if int(currentScore) < int(OScore): 
			firestore_collection.update("Hard",{'HighScore': currentScore})
		elif int(currentScore) > int(OScore): 
			firestore_collection.update("Hard",{'HighScore': OScore})
		noOfTimesPlayed += 1
		if noOfTimesPlayed == 1:
			firestore_collection.update("Hard",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
		firestore_collection.update("Hard",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
		if noOfTimesPlayed > 1:
			var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
			firestore_collection.update("Hard",{'SumScore': int(sumScore)})
			var avgScore = floor(sumScore / noOfTimesPlayed)
			firestore_collection.update("Hard",{'AvgScore': int(avgScore)})

	OScore = ""
	currentScore = ""
	
	#Player's Total Average Score accross All Difficulty Levels		
	firestore_collection2  = Firebase.Firestore.collection("userdata/"+player_email+"/OScore")
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
	#data end
	
func start_game() -> void:
	show_circles()
	timer.start()

func show_circles() -> void:
	circles_manager.visible = true


func hide_circles() -> void:
	circles_manager.visible = false


func _on_Timer_timeout():
	seconds_elapsed_in_game += 1
	print(seconds_elapsed_in_game)


func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ObservationGame/ObservationGameInstructionPage.tscn")
