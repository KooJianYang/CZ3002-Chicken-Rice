extends Control

onready var circles_manager = $CirclesManager
onready var countdown_label = $CountdownLabel
onready var game_end = $GameEnd
onready var timer = $Timer
var difficulty = GlobalScript.ObservationGameDifficulty
var circles_to_spawn_based_on_difficulty = [8, 16, 25]
var seconds_elapsed_in_game : int = 0

func _ready() -> void:
	set_up_game_based_on_difficulty(difficulty)
	circles_manager.connect("connected_all_circles", self, "end_game")
	countdown_label.connect("finished_countdown", self, "start_game")
	

func set_up_game_based_on_difficulty(difficulty : int) -> void:
	var number_of_circles_to_spawn : int = circles_to_spawn_based_on_difficulty[difficulty]
	circles_manager.spawn_circles(number_of_circles_to_spawn)
	circles_manager.last_circle_to_connect = number_of_circles_to_spawn


func end_game() -> void:
	game_end.visible = true
	
	
	hide_circles()
	timer.stop()
	game_end.get_node("TimeTakenLabel").update_time_taken_label(seconds_elapsed_in_game)

func start_game() -> void:
	show_circles()
	timer.start()

func show_circles() -> void:
	circles_manager.visible = true


func hide_circles() -> void:
	circles_manager.visible = false


func _on_Timer_timeout():
	seconds_elapsed_in_game += 1
	print(seconds_elapsed_in_game)


func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ObservationGame/ObservationGameInstructionPage.tscn")
