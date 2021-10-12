extends HBoxContainer


func update_parameter_to_fill(new_value : String) -> void:
	get_child(1).text = new_value
