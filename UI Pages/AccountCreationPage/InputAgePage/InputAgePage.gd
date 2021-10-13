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
	firestore_collection.add(player_email,{'Name': Name,'Email':player_email,'Age': Age, 'MScore': '', 'RScore': '', 'JScore': '', 'OScore': ''})
	
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")


