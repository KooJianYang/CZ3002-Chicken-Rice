extends Control

func _on_ConfirmAgeButton_pressed():
	var player_email = get_node("/root/AccountCreationPage")
	var firestore_collection : FirestoreCollection = Firebase.Firestore.collection("userdata")
	#firestore_collection.get("Age")
	#var document : FirestoreDocument = yield(firestore_collection,"get_document")
	#print(document)
	#print("xd")
	var Age = $AgeInput.text
	$Message.text= "Successfully saved!"
	firestore_collection.add(player_email.curemail,{'Name':player_email.curemail,'Age': Age})
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")

#player_email.userinfo.email,{'Name':player_email.userinfo.email,'Age': 30}
