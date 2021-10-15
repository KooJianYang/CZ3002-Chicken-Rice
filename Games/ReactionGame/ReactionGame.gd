extends Control

#button 1
onready var button :=$Button1
onready var timer_btn1 :=$Button1/Timer_for_color
onready var timer_for_reaction :=$Button1/Timer_for_reaction
onready var time_total := $Statistics/Timer
onready var timeTaken = $GameEnd/GameEndContainer/TimeTaken
onready var end = $GameEnd

var rng= RandomNumberGenerator.new()
var start_epoch  
var current_epoch 
var elapsed_time = 0
var avg_time = 0
var count = 0
var difficulty = GlobalScript.ReactionGameDifficulty





func _ready():
	button.set_modulate(Color(1,0,0,0.5))
	rng.randomize()
	random_timing_color()  #calls to change button color randomly
	end.visible = false



func _process(delta):
	if count == 3:  #if button is pressed 3 times when its green
		enter_end_game() 



func random_timing_color(): 
	timer_btn1.set_wait_time(rng.randi_range(1,7))
	timer_btn1.start()  



func _on_Timer_timeout():   # for btn 1: whem timer runs out, button changes colour

	button.set_modulate(Color(0,1,0,0.5))  # set color to green
	timer_for_reaction.start()  # start timing for reaction
	start_epoch = OS.get_ticks_msec()
	random_timing_color()
	if count>2:
		timer_btn1.stop()
		button.set_modulate(Color(1,0,0,0.5))



func _on_Button_pressed():
	if button.get_modulate() == Color(1,0,0,0.5):  #if user press when red
		button.text = str("Press only when green")
	else:
		count+= 1
		current_epoch = OS.get_ticks_msec()
		elapsed_time = current_epoch - start_epoch
		button.set_modulate(Color(1,0,0,0.5))  #set back to red
		time_total.text = str(elapsed_time) + "msec"  #display every reaction time



func enter_end_game():
	avg_time = elapsed_time/3
	end_game()



func end_game():
	button.visible = false
	end.visible = true
	timeTaken.text = str(avg_time) + "milliseconds"



func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ReactionGame/ReactionGameInstructionPage.tscn")
