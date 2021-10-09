extends Control

func _on_ResetButton_pressed():
	var email = $EmailInput.text
	Firebase.Auth.send_password_reset_email(email)

func _on_Backbutton_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage2/LoginPage2.tscn")
