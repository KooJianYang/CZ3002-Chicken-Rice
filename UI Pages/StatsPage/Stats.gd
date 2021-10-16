extends Control

onready var LeftButton = $Pages/Left
onready var RightButton = $Pages/Right
onready var CurrentPage = $Pages/CurrentPage
onready var GameName = $GameName

var current = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	LeftButton.set_disabled(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Left_pressed():
	current -= 1

	CurrentPage.text = str(current+1)+"/4"
	if current == 0:
		GameName.text= "Memory Game"
		LeftButton.set_disabled(true)
	if current == 1:
		GameName.text= "Judgement Game"
	if current == 2:
		GameName.text= "Reaction Game"
	if current < 3:
		RightButton.set_disabled(false)
	if current ==3:
		GameName.text= "Observation Game"


func _on_Right_pressed():
	current += 1
	CurrentPage.text = str(current+1)+"/4"

	if current > 0:
		LeftButton.set_disabled(false)
	if current == 0:
		GameName.text= "Memory Game"
	if current == 1:
		GameName.text= "Judgement Game"
	if current == 2:
		GameName.text= "Reaction Game"
	if current ==3:
		GameName.text= "Observation Game"
		RightButton.set_disabled(true)

func _on_TextureButton_pressed():
	get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")
