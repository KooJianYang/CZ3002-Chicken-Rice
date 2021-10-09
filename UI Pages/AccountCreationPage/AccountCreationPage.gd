extends Control

var curemail
# export(PackedScene) var home_page

func _ready():
	Firebase.Auth.connect("signup_succeeded", self, "_on_FirebaseAuth_signup_succeeded")
	Firebase.Auth.connect("signup_failed", self, "_on_FirebaseAuth_signup_failed")

func _on_CreateAccountButton_pressed():
	var email = $EmailInput.text
	var password = $PasswordInput.text
	if email.empty():
		$Message.visible=true
		$Message.text= "Please enter Email"
	elif password.empty():
		$Message.visible=true
		$Message.text= "Please enter Password"
	elif len(password) < 6:
		$Message.visible=true
		$Message.text= "Password must have minimum of 6 characters!"
	Firebase.Auth.signup_with_email_and_password(email, password)	

func _on_FirebaseAuth_signup_succeeded(auth_info):
	curemail= auth_info.email
	print("Success "+ curemail)
	Firebase.Auth.send_account_verification_email()
	get_tree().change_scene("res://UI Pages/InputAgePage/InputAgePage.tscn")

func _on_FirebaseAuth_signup_failed(error_code, message):
	$Message.visible=true
	if (message=="EMAIL_EXISTS"):
		$Message.text= "Email already registered."
	print("error code: " + str(error_code))
	print("message: " + str(message))

func _on_Back_button_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")
