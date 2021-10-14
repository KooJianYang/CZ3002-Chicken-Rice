extends Control

var is_started = false
var game_won = false
var start_epoch
var current_epoch
var time_taken
var total_moves
var difficulty = GlobalScript.JudgementGameDifficulty
var document_task : FirestoreTask 
var document: FirestoreDocument 
var firestore_collection : FirestoreCollection
var firestore_collection2 : FirestoreCollection
var currentTime
var player_email

onready var board = $MarginContainer/VBoxContainer/GameView/Board
onready var overlay = $MarginContainer/VBoxContainer/GameView/StartOverlay
onready var overlay_text = $MarginContainer/VBoxContainer/GameView/StartOverlay/TextOverlay
onready var move_value = $MarginContainer/VBoxContainer/Statistics/Sections/MovesSection/Moves
onready var timer_value = $MarginContainer/VBoxContainer/Statistics/Sections/TimerSection/Timer
onready var anim_player = $AnimationPlayer
onready var restartBtn = $MarginContainer/VBoxContainer/HSeparator2/RestartButton
onready var final_time = $GameEnd/GameEndContainer/TimeTaken
onready var final_moves = $GameEnd/GameEndContainer/MovesTaken
onready var gameEnd_overlay = $GameEnd

func _ready():
	overlay.visible = true
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
	
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/JScore")
	if difficulty == 3 or null:
		document_task = firestore_collection.get("Easy")
	elif difficulty == 4:
		document_task = firestore_collection.get("Normal")
	elif difficulty == 5:
		document_task = firestore_collection.get("Hard")
	document= yield(document_task, "get_document")
	
func _process(_delta):
	if is_started:
		current_epoch = OS.get_ticks_msec()
		var time_since_game_start = current_epoch - start_epoch
		timer_value.text = str(floor(time_since_game_start/1000)) + '.' + str(floor(fmod(time_since_game_start, 1000)/10)) + 's'
	else:
		if not game_won:
			timer_value.text = '0.00s'

func _on_Board_game_started():
	if game_won:
		return
	start_epoch = OS.get_ticks_msec()
	move_value.text = str(0)
	overlay.visible = false
	is_started = true
	game_won = false


func _on_Board_game_won():
	var noOfTimesPlayed = (document.doc_fields.get('NoOfTimesPlayed'))
	overlay_text.text = 'Nice Work!\nGo Back to Select a Difficulty Again'
	overlay.visible = true
	is_started = false
	game_won = true
	restartBtn.disabled = true
	var time_since_game_start = current_epoch - start_epoch
	time_taken = floor(time_since_game_start/1000) + floor(fmod(time_since_game_start, 1000)/10)/100
	total_moves = board.move_count
	print(str(floor(fmod(time_since_game_start, 1000)/10)), "s")
	print("time taken = ", time_taken, "s")
	print("moves = ", total_moves)
	gameEnd_overlay.visible = true
	final_time.text = str(time_taken) + " Seconds"
	final_moves.text = str(total_moves) + " Moves"
	#data start
	var index = 1
	var JScore = str(document.doc_fields.get('HighScore'))
	var currentScore = str(round(time_taken))
	if difficulty == 3 or null:
		if int(currentScore) < int(JScore): 
			firestore_collection.update("Easy",{'HighScore': currentScore})
		elif int(currentScore) > int(JScore): 
			firestore_collection.update("Easy",{'HighScore': JScore})
		noOfTimesPlayed += 1
		if noOfTimesPlayed == 1:
			firestore_collection.update("Easy",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
		firestore_collection.update("Easy",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
		if noOfTimesPlayed > 1:
			var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
			firestore_collection.update("Easy",{'SumScore': int(sumScore)})
			var avgScore = floor(sumScore / noOfTimesPlayed)
			firestore_collection.update("Easy",{'AvgScore': int(avgScore)})
	elif difficulty == 4:
		if int(currentScore) < int(JScore): 
			firestore_collection.update("Normal",{'HighScore': currentScore})
		elif int(currentScore) > int(JScore): 
			firestore_collection.update("Normal",{'HighScore': JScore})
		noOfTimesPlayed += 1
		if noOfTimesPlayed == 1:
			firestore_collection.update("Normal",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
		firestore_collection.update("Normal",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
		if noOfTimesPlayed > 1:
			var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
			firestore_collection.update("Normal",{'SumScore': int(sumScore)})
			var avgScore = floor(sumScore / noOfTimesPlayed)
			firestore_collection.update("Normal",{'AvgScore': int(avgScore)})
	elif difficulty == 5:
		if int(currentScore) < int(JScore): 
			firestore_collection.update("Hard",{'HighScore': currentScore})
		elif int(currentScore) > int(JScore): 
			firestore_collection.update("Hard",{'HighScore': JScore})
		noOfTimesPlayed += 1
		if noOfTimesPlayed == 1:
			firestore_collection.update("Hard",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
		firestore_collection.update("Hard",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
		if noOfTimesPlayed > 1:
			var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
			firestore_collection.update("Hard",{'SumScore': int(sumScore)})
			var avgScore = floor(sumScore / noOfTimesPlayed)
			firestore_collection.update("Hard",{'AvgScore': int(avgScore)})

	JScore = ""
	currentScore = ""
	
	#Player's Total Average Score accross All Difficulty Levels		
	firestore_collection2  = Firebase.Firestore.collection("userdata/"+player_email+"/JScore")
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
		


func _on_RestartButton_pressed():
	if not is_started and not game_won:
		print("restart aint working")
		return
	is_started = true
	overlay.visible = false
	game_won = false
	board.reset_move_count()
	board.scramble_board()
	board.game_state = board.GAME_STATES.STARTED
	start_epoch = OS.get_ticks_msec()
	


func _on_Board_moves_updated(move_count):
	if not is_started:
		return
	move_value.text = str(move_count)


func _on_SettingsScreen_board_size_update(new_size):
	board.update_size(new_size)
	overlay_text.text = 'Click to start'
	overlay.visible = true
	is_started = false


func _on_SettingsScreen_show_numbers_update(state):
	board.set_tile_numbers(state)


func _on_SettingsButton_pressed():
	anim_player.play("show_settings")


func _on_SettingsScreen_hide_settings():
	anim_player.play_backwards("show_settings")


func _on_SettingsScreen_background_update(texture: ImageTexture):
	print('updating background texture now')
	board.update_background_texture(texture)


func _on_BackButton_pressed():
	var _error = get_tree().change_scene("res://UI Pages/InstructionPages/JudgementGame/JudgementGameInstructionPage.tscn")
