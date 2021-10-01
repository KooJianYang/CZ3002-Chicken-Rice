extends Control

# export(PackedScene) var home_page


func _on_ConfirmAgeButton_pressed():
	var firestore_collection : FirestoreCollection = Firebase.Firestore.collection("userdata")
	firestore_collection.get("Userscore")
	var document : FirestoreDocument = yield(firestore_collection,"get_document")
	print(document)
	var Age = $AgeInput.text
	pass # Replace with function body.
