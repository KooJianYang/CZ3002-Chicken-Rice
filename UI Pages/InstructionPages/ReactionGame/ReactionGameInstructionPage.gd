extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	if GlobalScript.ReactionGameDifficulty == 0:
		get_tree().change_scene("res://Games/ReactionGame/ReactionGame.tscn")
	if GlobalScript.ReactionGameDifficulty == 1:
		get_tree().change_scene("res://Games/ReactionGame/ReactionDifficulty2.tscn")
		

func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")


func _on_Easy_pressed():
	GlobalScript.ReactionGameDifficulty = 0
	


func _on_Normal_pressed():
	GlobalScript.ReactionGameDifficulty = 1


func _on_Hard_pressed():
	GlobalScript.ReactionGameDifficulty = 2
