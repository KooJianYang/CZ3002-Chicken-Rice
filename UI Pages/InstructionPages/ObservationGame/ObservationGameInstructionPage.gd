extends Control

onready var InstructionPic = $Instructions/Container/InstructionImages
onready var LeftButton = $Pages/Left
onready var RightButton = $Pages/Right
onready var CurrentPage = $Pages/CurrentPage
var stepone = load("res://Assets/ObservationGame/step1.png")
var steptwo = load("res://Assets/ObservationGame/step2.png")
var stepthree = load("res://Assets/ObservationGame/step3.png")
var stepfour = load("res://Assets/ObservationGame/step4.png")
var stepfive = load("res://Assets/ObservationGame/step5.png")
var stepList = [stepone, steptwo, stepthree, stepfour, stepfive]
var current = 0

func _ready() -> void:
	reset_game_difficulty()
	InstructionPic.set_texture(stepone)
	LeftButton.set_disabled(true)
	CurrentPage.text = str(current+1)+"/5"


func _on_Left_pressed():
	current -= 1
	InstructionPic.set_texture(stepList[current])
	CurrentPage.text = str(current+1)+"/5"
	if current == 0:
		LeftButton.set_disabled(true)
	if current < 4:
		RightButton.set_disabled(false)

func _on_Right_pressed():
	current += 1
	InstructionPic.set_texture(stepList[current])
	CurrentPage.text = str(current+1)+"/5"
	if current == 4:
		RightButton.set_disabled(true)
	if current > 0:
		LeftButton.set_disabled(false)

func reset_game_difficulty() -> void:
	GlobalScript.ObservationGameDifficulty = 0

func _on_Easy_pressed() -> void:
	GlobalScript.ObservationGameDifficulty = 0
	print(GlobalScript.ObservationGameDifficulty)

func _on_Normal_pressed() -> void:
	GlobalScript.ObservationGameDifficulty = 1
	print(GlobalScript.ObservationGameDifficulty)

func _on_Hard_pressed() -> void:
	GlobalScript.ObservationGameDifficulty = 2
	print(GlobalScript.ObservationGameDifficulty)


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://Games/ObservationGame/ObservationGame.tscn")


func _on_BackButton_pressed() -> void:
	get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")

