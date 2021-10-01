extends Control

export(PackedScene) var home_page
export(PackedScene) var login_page

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
	print("Error code: " + str(error_code))
	print("Message: " + str(message))

func _on_LoginButton_pressed():
	var email = $EmailInput.text
	var password = $PasswordInput.text
	Firebase.Auth.login_with_email_and_password(email,password)

func _on_ForgetPassword_pressed():
	var email = $EmailInput.text
	Firebase.Auth.send_password_reset_email(email)


func _on_Back_button_pressed():
	get_tree().change_scene_to(login_page)
