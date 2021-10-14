extends Control

func _on_ConfirmAgeButton_pressed():
	var player_email = 	GetEmail.ReturnEmail()
	var firestore_collection : FirestoreCollection = Firebase.Firestore.collection("userdata")
	#firestore_collection.get("Age")
	#var document : FirestoreDocument = yield(firestore_collection,"get_document")
	#print(document)
	#print("xd")
	var Name = $VBoxContainer/NameInput.text
	var Age = $VBoxContainer/AgeInput.text
	$Message.text= "Successfully saved!"
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
	document_task = firestore_collection2.add("AvgScore")
	
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
	
	firestore_collection3.update("Easy",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
	firestore_collection3.update("Normal",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
	firestore_collection3.update("Hard",{'HighScore': str(null), 'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})
	firestore_collection3.update("AvgScore",{'NoOfTimesPlayed': int(0), 'AvgScore': int(0), 'SumScore': int(0)})

	
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")



