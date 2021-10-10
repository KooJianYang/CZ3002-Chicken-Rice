extends Control

onready var InstructionPic = $Instructions/Container/InstructionImages
onready var LeftButton = $Pages/Left
onready var RightButton = $Pages/Right
onready var CurrentPage = $Pages/CurrentPage
var stepone = load("res://Assets/MemoryGame/step 1.png")
var steptwo = load("res://Assets/MemoryGame/step 2.png")
var stepthree = load("res://Assets/MemoryGame/step 3.png")
var stepfour = load("res://Assets/MemoryGame/step 4.png")
var stepfive = load("res://Assets/MemoryGame/step 5.png")
var stepsix = load("res://Assets/MemoryGame/step 6.png")
var stepList = [stepone, steptwo, stepthree, stepfour, stepfive, stepsix]
var current = 0

func _ready():
	InstructionPic.set_texture(stepone)
	LeftButton.set_disabled(true)
	CurrentPage.text = str(current+1)+"/6"


func _on_Left_pressed():
	current -= 1
	InstructionPic.set_texture(stepList[current])
	CurrentPage.text = str(current+1)+"/6"
	if current == 0:
		LeftButton.set_disabled(true)
	if current < 5:
		RightButton.set_disabled(false)

func _on_Right_pressed():
	current += 1
	InstructionPic.set_texture(stepList[current])
	CurrentPage.text = str(current+1)+"/6"
	if current == 5:
		RightButton.set_disabled(true)
	if current > 0:
		LeftButton.set_disabled(false)


func _on_Easy_pressed():
	GlobalScript.MemoryGameDifficulty = 0
	print(GlobalScript.MemoryGameDifficulty)

func _on_Normal_pressed():
	GlobalScript.MemoryGameDifficulty = 1
	print(GlobalScript.MemoryGameDifficulty)

func _on_Hard_pressed():
	GlobalScript.MemoryGameDifficulty = 2
	print(GlobalScript.MemoryGameDifficulty)


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Games/MemoryGame/MemoryGame.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")


