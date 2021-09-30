extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	var _error = get_tree().change_scene("res://UI Pages/InstructionPages/JudgementGame/Game/game/game_scene.tscn")



func _on_PlayButton_pressed():
	var _error = get_tree().change_scene("res:///Games/JudgementGame/Game/game/game_scene.tscn")


func _on_BackButton_pressed():
	var _error = get_tree().change_scene("res://UI Pages/HomePage/HomePage.tscn")
