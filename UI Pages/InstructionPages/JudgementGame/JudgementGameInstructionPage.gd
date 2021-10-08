extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.JudgementGameDifficulty = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	var _error = get_tree().change_scene("res://UI Pages/InstructionPages/JudgementGame/Game/game/game_scene.tscn")

func _on_PlayButton_pressed():
	var _error = get_tree().change_scene("res:///Games/JudgementGame/Game/game/game_scene.tscn")

func _on_BackButton_pressed():
	var _error = get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")

func _on_Easy_pressed():
	GlobalScript.JudgementGameDifficulty = 3
	# print("board size = ", GlobalScript.JudgementGameDifficulty)

func _on_Normal_pressed():
	GlobalScript.JudgementGameDifficulty = 4
	# print("board size = ", GlobalScript.JudgementGameDifficulty)

func _on_Hard_pressed():
	GlobalScript.JudgementGameDifficulty = 5
	# print("board size = ", GlobalScript.JudgementGameDifficulty)
