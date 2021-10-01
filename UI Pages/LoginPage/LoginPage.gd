extends Control

export(PackedScene) var login_page_2
export(PackedScene) var account_creation_page


func _on_LoginWithEmailButton_pressed():
	get_tree().change_scene_to(login_page_2)


func _on_CreateNewAccountButton_pressed():
	get_tree().change_scene_to(account_creation_page)
	
