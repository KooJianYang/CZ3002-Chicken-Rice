extends Control

export(String, FILE, "*.tscn,*.scn") var scene_to_go_back
onready var profile_parameters_manager = $ProfileParametersManager
var profile_pulled_from_firebase : Array = []

func _ready():
	profile_pulled_from_firebase = [GlobalScript.name_of_user, GlobalScript.email, GlobalScript.age]
	profile_parameters_manager.update_all_profile_parameters(profile_pulled_from_firebase)


func _on_BackButton_pressed():
	get_tree().change_scene(scene_to_go_back)



	
