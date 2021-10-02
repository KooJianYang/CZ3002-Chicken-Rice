extends Control

#button 1
onready var button :=$Button1
onready var timer_btn1 :=$Button1/Timer_for_color
onready var timer_for_reaction :=$Button1/Timer_for_reaction
onready var time_total := $Statistics/Timer

var rng= RandomNumberGenerator.new()
var start_epoch
var current_epoch
var elapsed_time
var avg_time
var count = 0
var difficulty = GlobalScript.ReactionGameDifficulty




# Called when the node enters the scene tree for the first time.
func _ready():
	button.set_modulate(Color(1,0,0,0.5))
	random_timing_color() #calls to change button color randomly
	



func _on_Button_pressed():
	if button.get_modulate() == Color(1,0,0,0.5): #if user press when red
		button.text = str("Press only when green")
	else:
		current_epoch = OS.get_ticks_msec()
		elapsed_time = current_epoch - start_epoch
		button.set_modulate(Color(1,0,0,0.5)) #set back to red

	

func random_timing_color(): 
	rng.randomize()
	timer_btn1.set_wait_time(rng.randi_range(2,5))
	timer_btn1.start()  

	
func _on_Timer_timeout():  # for btn 1: whem timer runs out, button changes colour
	count+= 1
	button.set_modulate(Color(0,1,0,0.5)) # set color to green
	timer_for_reaction.start() # start timing for reaction
	start_epoch = OS.get_ticks_msec()
	if count>3:
		timer_btn1.stop()
		button.set_modulate(Color(1,0,0,0.5))
		avg_time = elapsed_time/3
		time_total.text = str(elapsed_time) + "msec"



func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ReactionGame/ReactionGameInstructionPage.tscn")
