extends Control

onready var circles_manager = $CirclesManager
onready var countdown_label = $CountdownLabel
onready var game_end = $GameEnd
onready var timer = $Timer
var seconds_elapsed_in_game : int = 0

func _ready() -> void:
	circles_manager.spawn_circles(25)
	circles_manager.connect("connected_all_circles", self, "end_game")
	countdown_label.connect("finished_countdown", self, "start_game")
	

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
