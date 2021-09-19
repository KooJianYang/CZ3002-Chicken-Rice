extends Control

export(PackedScene) var memory_game_instruction_page
export(PackedScene) var reaction_game_instruction_page
export(PackedScene) var judgement_game_instruction_page
export(PackedScene) var observation_game_instruction_page



func _on_MemoryGameButton_pressed():
	get_tree().change_scene_to(memory_game_instruction_page)


func _on_ReactionGameButton_pressed():
	get_tree().change_scene_to(reaction_game_instruction_page)


func _on_JudgementGameButton_pressed():
	get_tree().change_scene_to(judgement_game_instruction_page)


func _on_ObservationGameButton_pressed():
	get_tree().change_scene_to(observation_game_instruction_page)
