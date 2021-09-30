extends Control

func _ready():
	pass


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

