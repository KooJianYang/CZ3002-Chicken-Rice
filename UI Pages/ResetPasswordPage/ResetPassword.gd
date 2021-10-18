extends Control

func _on_ResetButton_pressed():
	var email = $VBoxContainer/EmailInput.text
	var popup = $Popup
	var message = $Popup/Message
	if email.empty():
		$Message.visible=true
		$Message.text= "Please enter Email"
	else:
		Firebase.Auth.send_password_reset_email(email)
		popup.visible=true
		message.text = "Email has been sent\nPlease check your email to reset password"

func _on_Backbutton_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage2/LoginPage2.tscn")

func _on_okButton_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage2/LoginPage2.tscn")
