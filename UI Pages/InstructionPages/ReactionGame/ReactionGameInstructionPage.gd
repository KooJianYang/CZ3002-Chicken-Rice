extends Control
onready var InstructionPic = $Instructions/Container/InstructionImages
onready var LeftButton = $Pages/Left
onready var RightButton = $Pages/Right
onready var CurrentPage = $Pages/CurrentPage
var stepone = load("res://Assets/ReactionGame/step1.jpg")
var steptwo = load("res://Assets/ReactionGame/step2.jpg")
var stepthree = load("res://Assets/ReactionGame/step3.jpg")
var stepfour = load("res://Assets/ReactionGame/step4.jpg")
var stepList = [stepone, steptwo, stepthree, stepfour]
var current = 0



func _ready():
	reset_game_difficulty()

	InstructionPic.set_texture(stepone)
	LeftButton.set_disabled(true)
	CurrentPage.text = str(current+1)+"/4"
	GlobalScript.MemoryGameDifficulty = 0



func _on_Left_pressed():
	current -= 1
	InstructionPic.set_texture(stepList[current])
	CurrentPage.text = str(current+1)+"/4"
	if current == 0:
		LeftButton.set_disabled(true)
	if current < 3:
		RightButton.set_disabled(false)



func _on_Right_pressed():
	current += 1
	InstructionPic.set_texture(stepList[current])
	CurrentPage.text = str(current+1)+"/5"
	if current == 3:
		RightButton.set_disabled(true)
	if current > 0:
		LeftButton.set_disabled(false)



func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")


func reset_game_difficulty() -> void:
	GlobalScript.ObservationGameDifficulty = 0

func _on_Easy_pressed():
	GlobalScript.ReactionGameDifficulty = 0

func _on_Normal_pressed():
	GlobalScript.ReactionGameDifficulty = 1

func _on_Hard_pressed():
	GlobalScript.ReactionGameDifficulty = 2

func _on_PlayButton_pressed():
	if GlobalScript.ReactionGameDifficulty == 0:
		get_tree().change_scene("res://Games/ReactionGame/ReactionGame.tscn")
	elif GlobalScript.ReactionGameDifficulty == 1 :
		get_tree().change_scene("res://Games/ReactionGame/ReactionDifficulty2.tscn")
	elif GlobalScript.ReactionGameDifficulty == 2:
		get_tree().change_scene("res://Games/ReactionGame/ReactionDifficulty3.tscn")




