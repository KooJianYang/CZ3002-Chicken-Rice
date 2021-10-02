extends Control


func _ready() -> void:
	reset_game_difficulty()


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

