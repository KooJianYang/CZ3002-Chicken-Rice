extends Control

export(PackedScene) var login_page_2


func _on_LoginWithEmailButton_pressed():
	get_tree().change_scene_to(login_page_2)
