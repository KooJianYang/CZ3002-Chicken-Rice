extends Label

onready var interval_timer = $IntervalTimer
export (int) var seconds_left_to_start 
signal finished_countdown

func _on_StartTimer_timeout() -> void:
	seconds_left_to_start -= 1
	if seconds_left_to_start >= 1:
		text = str(seconds_left_to_start)
		interval_timer.start()
	elif seconds_left_to_start >= 0:
		text = "GO!"
		interval_timer.wait_time = 0.8
		interval_timer.start()
	else:
		text = ""
		emit_signal("finished_countdown")
