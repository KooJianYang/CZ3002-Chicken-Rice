extends Control

export(PackedScene) var home_page


var userinfo = null

func _ready():
	Firebase.Auth.connect("login_succeeded", self, "_on_FirebaseAuth_login_succeeded")
	Firebase.Auth.connect("login_failed", self, "_on_FirebaseAuth_login_failed")

func _on_FirebaseAuth_login_succeeded(auth_info):
	userinfo = auth_info
	Firebase.Auth.save_auth(auth_info)
	print("Success")
	get_tree().change_scene_to(home_page)

func _on_FirebaseAuth_login_failed(error_code, message):
	#var Msg=$Message.text
	$Message.visible=true
	if str(message)=="INVALID_EMAIL":
			$Message.text= "Invalid Email"
	elif str(message)=="MISSING_PASSWORD":
			$Message.text= "Invalid Password"
	elif str(message)=="EMAIL_NOT_FOUND":
			$Message.text= "Email not found! Please create account first"
	elif str(message)=="INVALID_PASSWORD":
			$Message.text= "Username or password is incorrect"
	else:
		$Message.text="Unknown Error"
	print("Error code: " + str(error_code))
	print("Message: " + str(message))

func _on_LoginButton_pressed():
	var email = $VBoxContainer/EmailInput.text
	var password = $VBoxContainer/PasswordInput.text
	Firebase.Auth.login_with_email_and_password(email,password)

func _on_ForgetPassword_pressed():
	get_tree().change_scene("res://UI Pages/ResetPasswordPage/ResetPassword.tscn")


func _on_Back_button_pressed():
	get_tree().change_scene("res://UI Pages/LoginPage/LoginPage.tscn")
