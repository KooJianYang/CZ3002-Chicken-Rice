extends Control



func _on_ConfirmAgeButton_pressed():
	var player_email = 	GetEmail.ReturnEmail()
	var firestore_collection : FirestoreCollection = Firebase.Firestore.collection("userdata")
	#firestore_collection.get("Age")
	#var document : FirestoreDocument = yield(firestore_collection,"get_document")
	
	var Name = $VBoxContainer/NameInput.text
	var Age = $VBoxContainer/AgeInput.text
	
	
	if Name.empty():
		$Message.visible=true
		$Message.text= "Please enter valid Name"
	elif Age.empty():
		$Message.visible=true
		$Message.text= "Please enter Age"
	elif !Age.is_valid_integer():
		$Message.visible=true
		$Message.text= "Please enter valid Age"
	
	else:
		firestore_collection.add(player_email,{'Name': Name,'Email':player_email,'Age': Age})
		
		var firestore_collection2 : FirestoreCollection = Firebase.Firestore.collection("userdata/"+player_email+"/JScore")
		var firestore_collection3 : FirestoreCollection = Firebase.Firestore.collection("userdata/"+player_email+"/MScore")
		var firestore_collection4 : FirestoreCollection = Firebase.Firestore.collection("userdata/"+player_email+"/OScore")
		var firestore_collection5 : FirestoreCollection = Firebase.Firestore.collection("userdata/"+player_email+"/RScore")
		var document_task : FirestoreTask 
		var document: FirestoreDocument 
		
		#Judgement Game
		document_task = firestore_collection2.add("Easy")
		document_task = firestore_collection2.add("Normal")
		document_task = firestore_collection2.add("Hard")

		#Memory Game
		document_task = firestore_collection3.add("Easy")
		document_task = firestore_collection3.add("Normal")
		document_task = firestore_collection3.add("Hard")
		
		#Observation Game
		document_task = firestore_collection4.add("Easy")
		document_task = firestore_collection4.add("Normal")
		document_task = firestore_collection4.add("Hard")
		
		#Reaction Game
		document_task = firestore_collection5.add("Easy")
		document_task = firestore_collection5.add("Normal")
		document_task = firestore_collection5.add("Hard")
		document= yield(document_task, "add_document")
		
		#Judgement Data
		firestore_collection2.update("Easy",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection2.update("Normal",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection2.update("Hard",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection2.update("AvgScore",{'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		
		#Memory Data
		firestore_collection3.update("Easy",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection3.update("Normal",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection3.update("Hard",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection3.update("AvgScore",{'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})

		#Observation Data
		firestore_collection4.update("Easy",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection4.update("Normal",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection4.update("Hard",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection4.update("AvgScore",{'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		
		#Reaction Data
		firestore_collection5.update("Easy",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection5.update("Normal",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection5.update("Hard",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		firestore_collection5.update("AvgScore",{'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
		var popup = $Popup
		var message = $Popup/Message
		popup.visible=true
		message.text = "Account successfully created \nClick OK to login"

func _on_okButton_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")

