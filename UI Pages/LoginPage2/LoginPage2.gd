extends Control

export(PackedScene) var home_page

func _on_LoginButton_pressed():
	get_tree().change_scene_to(home_page)
