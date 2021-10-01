extends Control

# export(PackedScene) var home_page

func _ready():
	Firebase.Auth.connect("signup_succeeded", self, "_on_FirebaseAuth_signup_succeeded")

func _on_CreateAccountButton_pressed():
	var email = $EmailInput.text
	var password = $PasswordInput.text
	Firebase.Auth.signup_with_email_and_password(email, password)

func _on_FirebaseAuth_signup_succeeded(auth_info):
	print("Success" + str(auth_info))
	Firebase.Auth.send_account_verification_email()
	# get_tree().change_scene_to(home_page)
