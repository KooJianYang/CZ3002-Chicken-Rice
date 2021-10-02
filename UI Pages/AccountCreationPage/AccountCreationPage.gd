extends Control

var curemail
# export(PackedScene) var home_page

func _ready():
	Firebase.Auth.connect("signup_succeeded", self, "_on_FirebaseAuth_signup_succeeded")

func _on_CreateAccountButton_pressed():
	var email = $EmailInput.text
	var password = $PasswordInput.text
	if email.empty():
		$Message.text= "Please enter Email"
	elif password.empty():
		$Message.text= "Please enter Password"
	Firebase.Auth.signup_with_email_and_password(email, password)

func _on_FirebaseAuth_signup_succeeded(auth_info):
	curemail= auth_info.email
	print("Success"+ curemail)
	Firebase.Auth.send_account_verification_email()
	get_tree().change_scene("res://UI Pages/InputAgePage/InputAgePage.tscn")

func _on_Back_button_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")
