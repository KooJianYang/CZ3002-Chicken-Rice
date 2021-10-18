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
#var document_EasyTask : FirestoreTask 
#var documentEasy: FirestoreDocument
#var document_NormalTask : FirestoreTask 
#var documentNormal: FirestoreDocument 
#var document_HardTask : FirestoreTask 
#var documentHard: FirestoreDocument 
#var firestore_collection : FirestoreCollection
#var firestore_collection2 : FirestoreCollection
var current = 0
#var player_email

# Called when the node enters the scene tree for the first time.
func _ready():
#	player_email = GlobalScript.email
#	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/MScore")
	
	LeftButton.set_disabled(true)
	
#	MemoryAve.text =
#	ReactAve.text = 
#	ObservationAve.text =
#	JudgementAve.text =
#	MemoryGlobal.text =
#	ReactGlobal.text =
#	ObservationGlobal.text =
#	JudgementGlobal.text =


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
