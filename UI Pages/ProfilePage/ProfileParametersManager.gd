extends VBoxContainer


func update_all_profile_parameters(profile : Array) -> void:
	var index : int = 0
	for profile_parameter in get_children():
		profile_parameter.update_parameter_to_fill(profile[index])
		index += 1
