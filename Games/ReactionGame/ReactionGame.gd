extends Control

onready var button :=$Button1
onready var timer_btn1 :=$Button1/Timer_for_color
onready var timer_for_reaction :=$Button1/Timer_for_reaction
onready var time_total := $Statistics/Timer

var rng= RandomNumberGenerator.new()
var start_epoch
var current_epoch

# Called when the node enters the scene tree for the first time.
func _ready():
	random_timing_color() #calls to change button color randomly


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():  #for button 1
	current_epoch = OS.get_ticks_msec()
	var elapsed_time = current_epoch - start_epoch
	var elapsed_time_in_sec = elapsed_time/1000
	time_total.text = str(elapsed_time_in_sec)
	
	

func random_timing_color(): #for btn 1
	rng.randomize()
	timer_btn1.set_wait_time(rng.randi_range(2,15))
	timer_btn1.start()
	start_epoch = OS.get_ticks_msec()
	



func _on_Timer_timeout():  #for btn 1
	button.set_modulate(Color(0.5,1,0.5,0.5))
	timer_for_reaction.start()


func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ReactionGame/ReactionGameInstructionPage.tscn")
