extends Label

var minutes : int
var seconds : int

func update_time_taken_label(seconds_elapsed_in_game : int):
	compute_time_taken_to_finish_game(seconds_elapsed_in_game)
	text = str(minutes) + "min " + str(seconds) + "s" 
	

func compute_time_taken_to_finish_game(seconds_elapsed_in_game : int):
	minutes = seconds_elapsed_in_game / 60
	seconds = seconds_elapsed_in_game - (minutes * 60)
