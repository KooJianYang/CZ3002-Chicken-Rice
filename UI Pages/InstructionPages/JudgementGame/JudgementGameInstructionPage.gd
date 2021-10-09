extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var InstructionPic = $Instructions/Container/InstructionImages
onready var LeftButton = $Pages/Left
onready var RightButton = $Pages/Right
onready var CurrentPage = $Pages/CurrentPage
var stepone = load("res://Assets/JudgementGame/instruction images/1.png")
var steptwo = load("res://Assets/JudgementGame/instruction images/2.png")
var stepthree = load("res://Assets/JudgementGame/instruction images/3.png")
var stepfour = load("res://Assets/JudgementGame/instruction images/4.png")
var stepfive = load("res://Assets/JudgementGame/instruction images/5.png")
var stepsix = load("res://Assets/JudgementGame/instruction images/6.png")
var stepList = [stepone, steptwo, stepthree, stepfour, stepfive, stepsix]
var current = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.JudgementGameDifficulty = 3
	InstructionPic.set_texture(stepone)
	LeftButton.set_disabled(true)
	CurrentPage.text = str(current+1) + "/6"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#------------------------------------------------------------------------------#
# Instruction Arrows
#------------------------------------------------------------------------------#
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

#------------------------------------------------------------------------------#
# Start Game/Back Buttons
#------------------------------------------------------------------------------#
func _on_PlayButton_pressed():
	var _error = get_tree().change_scene("res:///Games/JudgementGame/Game/game/game_scene.tscn")

func _on_BackButton_pressed():
	var _error = get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")

#------------------------------------------------------------------------------#
# Difficulty Buttons
#------------------------------------------------------------------------------#
func _on_Easy_pressed():
	GlobalScript.JudgementGameDifficulty = 3
	# print("board size = ", GlobalScript.JudgementGameDifficulty)

func _on_Normal_pressed():
	GlobalScript.JudgementGameDifficulty = 4
	# print("board size = ", GlobalScript.JudgementGameDifficulty)

func _on_Hard_pressed():
	GlobalScript.JudgementGameDifficulty = 5
	# print("board size = ", GlobalScript.JudgementGameDifficulty)
