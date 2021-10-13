extends Control

var curEmail
# export(PackedScene) var home_page

func _ready():
	Firebase.Auth.connect("signup_succeeded", self, "_on_FirebaseAuth_signup_succeeded")
	Firebase.Auth.connect("signup_failed", self, "_on_FirebaseAuth_signup_failed")

func _on_CreateAccountButton_pressed():
	var email = $VBoxContainer/EmailInput.text
	GetEmail.StoreEmail(email)
	var password = $VBoxContainer/PasswordInput.text
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
	curEmail= auth_info.email
	print("Success "+ curEmail)
	Firebase.Auth.send_account_verification_email()
	get_tree().change_scene("res://UI Pages/AccountCreationPage/InputAgePage/InputAgePage.tscn")

func _on_FirebaseAuth_signup_failed(error_code, messages):
	#$Message.visible=true
	get_node("Message").visible=true
	if (messages=="EMAIL_EXISTS"):
		$Message.text= "Email already registered."
	elif (messages=="INVALID_EMAIL"):
		$Message.text= "Please enter a valid Email."
	print("error code: " + str(error_code))
	print("message: " + str(messages))

func _on_Backbutton_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")
