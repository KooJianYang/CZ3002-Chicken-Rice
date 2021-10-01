# ---------------------------------------------------- #
#                 SCRIPT VERSION = 2.1                 #
#                 ====================                 #
# please, remember to increment the version to +0.1    #
# if you are going to make changes that will commited  #
# ---------------------------------------------------- #

extends Node

const ENVIRONMENT_VARIABLES : String = "firebase/environment_variables/"
onready var Auth : FirebaseAuth = $Auth
onready var Firestore : FirebaseFirestore = $Firestore
onready var Database : FirebaseDatabase = $Database
onready var Storage : FirebaseStorage = $Storage

# Configuration used by all files in this project
# These values can be found in your Firebase Project
# See the README on Github for how to access
var config : Dictionary = {
	"apiKey": "AIzaSyAhesqIdYsHtHYCsUkYWqc56tTwWUXQBj0",
	"authDomain": "cz3002-34e58.firebaseapp.com",
	"databaseURL": "",
	"projectId": "cz3002-34e58",
	"storageBucket": "cz3002-34e58.appspot.com",
	"messagingSenderId": "311751884896",
	"appId": "1:311751884896:web:d1903f8439d13e7edcc305",
	"measurementId": "G-E74VPF3HK3",
	"clientId": "",
	"clientSecret": "",
	}

func load_config() -> void:
	if ProjectSettings.has_setting(ENVIRONMENT_VARIABLES+"apiKey"):
		for key in config.keys():
			config[key] = ProjectSettings.get_setting(ENVIRONMENT_VARIABLES+key)
	else:
		printerr("No configuration settings found, add them in override.cfg file.")

func _ready() -> void:
	load_config()
	Auth.set_config(config)
	Firestore.set_config(config)
	Database.set_config(config)
	Storage.set_config(config)
	Auth.connect("login_succeeded", Database, "_on_FirebaseAuth_login_succeeded")
	Auth.connect("signup_succeeded", Database, "_on_FirebaseAuth_login_succeeded")
	Auth.connect("token_refresh_succeeded", Database, "_on_FirebaseAuth_token_refresh_succeeded")
	Auth.connect("login_succeeded", Firestore, "_on_FirebaseAuth_login_succeeded")
	Auth.connect("signup_succeeded", Firestore, "_on_FirebaseAuth_login_succeeded")
	Auth.connect("token_refresh_succeeded", Firestore, "_on_FirebaseAuth_token_refresh_succeeded")
	Auth.connect("login_succeeded", Storage, "_on_FirebaseAuth_login_succeeded")
	Auth.connect("signup_succeeded", Storage, "_on_FirebaseAuth_login_succeeded")
	Auth.connect("token_refresh_succeeded", Storage, "_on_FirebaseAuth_token_refresh_succeeded")
