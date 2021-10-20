extends Control

onready var LeftButton = $Pages/Left
onready var RightButton = $Pages/Right
onready var CurrentPage = $Pages/CurrentPage
onready var GameName = $GameName
onready var Chart = $MemoryChart
onready var MemoryAve = $Table/AverageScore/MemoryAverage
onready var ReactAve = $Table/AverageScore/ReactAverage
onready var ObservationAve = $Table/AverageScore/ObservationAverage
onready var JudgementAve = $Table/AverageScore/JudgementAverage
onready var MemoryGlobal = $Table/GlobalAverage/MemoryGlobal
onready var ReactGlobal = $Table/GlobalAverage/ReactGlobal
onready var ObservationGlobal = $Table/GlobalAverage/ObservationGlobal
onready var JudgementGlobal = $Table/GlobalAverage/JudgementGlobal
var document_M : FirestoreTask 
var documentM: FirestoreDocument
var document_J : FirestoreTask 
var documentJ: FirestoreDocument 
var document_O : FirestoreTask 
var documentO: FirestoreDocument
var document_R : FirestoreTask 
var documentR: FirestoreDocument
var document_task3 : FirestoreTask 
var document3: FirestoreDocument 
var firestore_collectionM : FirestoreCollection
var firestore_collectionJ : FirestoreCollection
var firestore_collectionO : FirestoreCollection
var firestore_collectionR : FirestoreCollection
var firestore_collection4 : FirestoreCollection
var current = 0
var player_email
var player_age

# Called when the node enters the scene tree for the first time.
func _ready():
	player_email = GlobalScript.email
	player_age = int(GlobalScript.age)
	firestore_collectionM = Firebase.Firestore.collection("userdata/"+player_email+"/MScore")
	firestore_collectionJ = Firebase.Firestore.collection("userdata/"+player_email+"/JScore")
	firestore_collectionO = Firebase.Firestore.collection("userdata/"+player_email+"/OScore")
	firestore_collectionR = Firebase.Firestore.collection("userdata/"+player_email+"/RScore")

	document_M = firestore_collectionM.get("AvgScore")
	documentM= yield(document_M, "get_document")
	document_J = firestore_collectionJ.get("AvgScore")
	documentJ= yield(document_J, "get_document")
	document_O = firestore_collectionO.get("AvgScore")
	documentO= yield(document_O, "get_document")
	document_R = firestore_collectionR.get("AvgScore")
	documentR= yield(document_R, "get_document")
	LeftButton.set_disabled(true)
	
	MemoryAve.text = str(documentM.doc_fields.get('AvgScore'))
	ReactAve.text = str(documentR.doc_fields.get('AvgScore'))
	ObservationAve.text = str(documentO.doc_fields.get('AvgScore'))
	JudgementAve.text = str(documentJ.doc_fields.get('AvgScore'))
	
	if player_age <= 30: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Below30/MScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		MemoryGlobal.text = str(oldSum)

	elif player_age >=31 and player_age <= 59: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/31to59/MScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		MemoryGlobal.text = str(oldSum)

	elif player_age >= 60: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Above60/MScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		MemoryGlobal.text = str(oldSum)

	if player_age <= 30: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Below30/RScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		ReactGlobal.text = str(oldSum)

	elif player_age >=31 and player_age <= 59: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/31to59/RScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		ReactGlobal.text = str(oldSum)

	elif player_age >= 60: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Above60/RScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		ReactGlobal.text = str(oldSum)

	if player_age <= 30: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Below30/OScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		ObservationGlobal.text = str(oldSum)

	elif player_age >=31 and player_age <= 59: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/31to59/OScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		ObservationGlobal.text = str(oldSum)

	elif player_age >= 60: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Above60/OScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		ObservationGlobal.text = str(oldSum)

	if player_age <= 30: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Below30/JScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		JudgementGlobal.text = str(oldSum)

	elif player_age >=31 and player_age <= 59: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/31to59/JScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		JudgementGlobal.text = str(oldSum)

	elif player_age >= 60: 
		firestore_collection4  = Firebase.Firestore.collection("globaldata/Above60/JScore")
		document_task3 = firestore_collection4.get("AvgScore")
		document3 = yield(document_task3, "get_document")
		var oldSum = document3.doc_fields.get('AvgScore')
		JudgementGlobal.text = str(oldSum)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Left_pressed():
	current -= 1
	
	CurrentPage.text = str(current+1)+"/4"
	if current == 0:
		GameName.text= "Memory Game"
		Chart.Stats("/MScore")
		LeftButton.set_disabled(true)
	if current == 1:
		Chart.Stats("/JScore")
		GameName.text= "Judgement Game"
	if current == 2:
		Chart.Stats("/RScore")
		GameName.text= "Reaction Game"
	if current < 3:
		RightButton.set_disabled(false)
	if current ==3:
		Chart.Stats("/OScore")
		GameName.text= "Observation Game"


func _on_Right_pressed():
	current += 1
	CurrentPage.text = str(current+1)+"/4"

	if current > 0:
		LeftButton.set_disabled(false)
	if current == 0:
		GameName.text= "Memory Game"
		Chart.Stats("/MScore")
	if current == 1:
		GameName.text= "Judgement Game"
		Chart.Stats("/JScore")
	if current == 2:
		GameName.text= "Reaction Game"
		Chart.Stats("/RScore")
	if current == 3:
		GameName.text= "Observation Game"
		Chart.Stats("/OScore")
		RightButton.set_disabled(true)

func _on_TextureButton_pressed():
	get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")
