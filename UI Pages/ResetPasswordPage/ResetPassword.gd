extends Control

export(PackedScene) var home_page



func _on_ResetButton_pressed():
	var email = $EmailInput.text
	Firebase.Auth.send_password_reset_email(email)

