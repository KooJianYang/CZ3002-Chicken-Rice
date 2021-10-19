extends Control

#button 1
onready var button :=$Button1
onready var timer_btn1 :=$Button1/Timer_for_color
onready var timer_for_reaction :=$Button1/Timer_for_reaction
onready var time_total := $Statistics/Timer
onready var timeTaken = $GameEnd/GameEndContainer/TimeTaken
onready var end = $GameEnd

var rng= RandomNumberGenerator.new()
var start_epoch  
var current_epoch 
var elapsed_time = 0
var avg_time = 0
var count = 0
var difficulty = GlobalScript.ReactionGameDifficulty


var document_task : FirestoreTask 
var document: FirestoreDocument 
var document_task2 : FirestoreTask 
var document2: FirestoreDocument 
var document_task3 : FirestoreTask 
var document3: FirestoreDocument 
var document_task4 : FirestoreTask 
var document4: FirestoreDocument 
var firestore_collection : FirestoreCollection
var firestore_collection2 : FirestoreCollection
var firestore_collection3 : FirestoreCollection
var firestore_collection4 : FirestoreCollection
var currentTime
var player_email
var player_age


func _ready():
	button.set_modulate(Color(1,0,0,0.5))
	rng.randomize()
	random_timing_color()  #calls to change button color randomly
	end.visible = false
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
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/RScore")
	document_task = firestore_collection.get("Easy")
	document= yield(document_task, "get_document")



func _process(delta):
	if count == 3:  #if button is pressed 3 times when its green
		enter_end_game() 
		count += 1 #to stop looping



func random_timing_color(): 
	timer_btn1.set_wait_time(rng.randi_range(1,7))
	timer_btn1.start()  



func _on_Timer_timeout():   # for btn 1: whem timer runs out, button changes colour

	button.set_modulate(Color(0,1,0,0.5))  # set color to green
	timer_for_reaction.start()  # start timing for reaction
	start_epoch = OS.get_ticks_msec()
	random_timing_color()
	if count>2:
		timer_btn1.stop()
		button.set_modulate(Color(1,0,0,0.5))



func _on_Button_pressed():
	if button.get_modulate() == Color(1,0,0,0.5):  #if user press when red
		button.text = str("Press only when green")
	else:
		count+= 1
		current_epoch = OS.get_ticks_msec()
		elapsed_time = current_epoch - start_epoch
		button.set_modulate(Color(1,0,0,0.5))  #set back to red
		time_total.text = str(elapsed_time) + "msec"  #display every reaction time



func enter_end_game():
	avg_time = elapsed_time/3
	end_game()



func end_game():
	button.visible = false
	end.visible = true
	timeTaken.text = str(avg_time) + "milliseconds"
	#Data start
	var noOfTimesPlayed = (document.doc_fields.get('NoOfTimesPlayed'))
	var index = 1
	var RScore = str(document.doc_fields.get('HighScore'))
	var currentScore = str(round(avg_time))
	if int(currentScore) < int(RScore): 
		firestore_collection.update("Easy",{'HighScore': currentScore})
	elif int(currentScore) > int(RScore): 
		firestore_collection.update("Easy",{'HighScore': RScore})
	noOfTimesPlayed += 1
	if noOfTimesPlayed == 1:
		firestore_collection.update("Easy",{'HighScore': currentScore, 'AvgScore': int(currentScore), 'SumScore': int(currentScore)})
	firestore_collection.update("Easy",{'NoOfTimesPlayed': noOfTimesPlayed, 'Score'+str(noOfTimesPlayed) : currentScore+", "+currentTime})
	if noOfTimesPlayed > 1:
		var sumScore = document.doc_fields.get('SumScore') + int(currentScore)
		firestore_collection.update("Easy",{'SumScore': int(sumScore)})
		var avgScore = floor(sumScore / noOfTimesPlayed)
		firestore_collection.update("Easy",{'AvgScore': int(avgScore)})

	RScore = ""
	currentScore = ""

	#Global Data start
	document_task4 = firestore_collection.get("AvgScore")
	document4 = yield(document_task4, "get_document")
	var getAvg = document4.doc_fields.get('AvgScore') 
	#Global Data end

	#Player's Total Average Score accross All Difficulty Levels		
	firestore_collection2  = Firebase.Firestore.collection("userdata/"+player_email+"/RScore")
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
	#Data end
	
	#Global Data start
	player_age = int(GlobalScript.age)
	yield(get_tree().create_timer(0.25),"timeout")
	document_task2 = firestore_collection.get("AvgScore")
	document2 = yield(document_task2, "get_document")
	var noOfTimesPlayed2 = document2.doc_fields.get('NoOfTimesPlayed')
	if noOfTimesPlayed == 1:
		if player_age <= 30: 
			firestore_collection4 = Firebase.Firestore.collection("globaldata/Below30/RScore")
			document_task3 = firestore_collection4.get("AvgScore")
			document3 = yield(document_task3, "get_document")
			var oldSum = document3.doc_fields.get('SumScore')
			var oldUsers = document3.doc_fields.get('NoOfUsers')
			var newUsers = oldUsers + 1
			var newSum = oldSum + totalAvg
			var avg = newSum / newUsers
			firestore_collection4.update("AvgScore",{'NoOfUsers': newUsers, 'SumScore': newSum, 'AvgScore': avg})
		elif player_age >=31 and player_age <= 59: 
			firestore_collection4 = Firebase.Firestore.collection("globaldata/31to59/RScore")
			document_task3 = firestore_collection4.get("AvgScore")
			document3 = yield(document_task3, "get_document")
			var oldSum = document3.doc_fields.get('SumScore')
			var oldUsers = document3.doc_fields.get('NoOfUsers')
			var newUsers = oldUsers + 1
			var newSum = oldSum + totalAvg
			var avg = newSum / newUsers
			firestore_collection4.update("AvgScore",{'NoOfUsers': newUsers, 'SumScore': newSum, 'AvgScore': avg})
		elif player_age >= 60: 
			firestore_collection4 = Firebase.Firestore.collection("globaldata/Above60/RScore")
			document_task3 = firestore_collection4.get("AvgScore")
			document3 = yield(document_task3, "get_document")
			var oldSum = document3.doc_fields.get('SumScore')
			var oldUsers = document3.doc_fields.get('NoOfUsers')
			var newUsers = oldUsers + 1
			var newSum = oldSum + totalAvg
			var avg = newSum / newUsers
			firestore_collection4.update("AvgScore",{'NoOfUsers': newUsers, 'SumScore': newSum, 'AvgScore': avg})
	elif noOfTimesPlayed2 > 1:
		if player_age <= 30: 
			if getAvg != totalAvg:
				firestore_collection4 = Firebase.Firestore.collection("globaldata/Below30/RScore")
				document_task3 = firestore_collection4.get("AvgScore")
				document3 = yield(document_task3, "get_document")
				var oldSum = document3.doc_fields.get('SumScore')
				var newSum = oldSum - getAvg + totalAvg
				var noOfUsers = document3.doc_fields.get('NoOfUsers')
				var newAvg = newSum / noOfUsers
				firestore_collection4.update("AvgScore",{'SumScore': newSum, 'AvgScore': newAvg})
		elif player_age >=31 and player_age <= 59: 
			if getAvg != totalAvg:
				firestore_collection4 = Firebase.Firestore.collection("globaldata/31to59/RScore")
				document_task3 = firestore_collection4.get("AvgScore")
				document3 = yield(document_task3, "get_document")
				var oldSum = document3.doc_fields.get('SumScore')
				var newSum = oldSum - getAvg + totalAvg
				var noOfUsers = document3.doc_fields.get('NoOfUsers')
				var newAvg = newSum / noOfUsers
				firestore_collection4.update("AvgScore",{'SumScore': newSum, 'AvgScore': newAvg})
		elif player_age >= 60: 
			if getAvg != totalAvg:
				firestore_collection4 = Firebase.Firestore.collection("globaldata/Above60/RScore")
				document_task3 = firestore_collection4.get("AvgScore")
				document3 = yield(document_task3, "get_document")
				var oldSum = document3.doc_fields.get('SumScore')
				var newSum = oldSum - getAvg + totalAvg
				var noOfUsers = document3.doc_fields.get('NoOfUsers')
				var newAvg = newSum / noOfUsers
				firestore_collection4.update("AvgScore",{'SumScore': newSum, 'AvgScore': newAvg})
	#Global Data end



func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ReactionGame/ReactionGameInstructionPage.tscn")
