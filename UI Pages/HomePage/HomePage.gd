extends Control

export(PackedScene) var memory_game_instruction_page
export(PackedScene) var reaction_game_instruction_page
export(PackedScene) var judgement_game_instruction_page
export(PackedScene) var observation_game_instruction_page
export(PackedScene) var profile_page

var document_task : FirestoreTask 
var document: FirestoreDocument 
var firestore_collection : FirestoreCollection

func _ready():
	firestore_collection  = Firebase.Firestore.collection("userdata")
	var player_email = GlobalScript.email
	document_task = firestore_collection.get(player_email)
	document= yield(document_task, "get_document")
	GlobalScript.age = str(document.doc_fields.get('Age'))
	GlobalScript.name_of_user = str(document.doc_fields.get('Name'))
	GlobalScript.email = str(document.doc_fields.get('Email'))
	
	print(GlobalScript.age)
	print(GlobalScript.name_of_user)
	print(GlobalScript.email)


func _on_MemoryGameButton_pressed():
	get_tree().change_scene_to(memory_game_instruction_page)


func _on_ReactionGameButton_pressed():
	get_tree().change_scene_to(reaction_game_instruction_page)


func _on_JudgementGameButton_pressed():
	get_tree().change_scene_to(judgement_game_instruction_page)


func _on_ObservationGameButton_pressed():
	get_tree().change_scene_to(observation_game_instruction_page)


func _on_ProfileButton_pressed():
	get_tree().change_scene_to(profile_page)
