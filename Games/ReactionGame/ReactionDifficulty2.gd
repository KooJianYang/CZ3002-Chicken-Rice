extends Control

#button 1
onready var btn1 :=$Button1
onready var btn1_time_color :=$Button1/Timer_for_color
onready var btn1_time_reaction :=$Button1/Timer_for_reaction
var start_epoch
var current_epoch
var elapsed_time = 0

#button 2
onready var btn2 :=$Button2
onready var btn2_time_color :=$Button2/Timer2_for_color
onready var btn2_time_reaction :=$Button2/Timer2_for_reaction
var start_epoch2
var current_epoch2
var elapsed_time2 = 0

#stats 
onready var time_total :=$Statistics/Timer

var rng= RandomNumberGenerator.new()
var avg_time = 0
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	btn1.set_modulate(Color(1,0,0,0.5)) 
	btn2.set_modulate(Color(1,0,0,0.5))
	random_time_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func random_time_color():
	rng.randomize()
	btn1_time_color.set_wait_time(rng.randi_range(2,5))
	btn1_time_color.start()

	btn2_time_color.set_wait_time(rng.randi_range(2,10))
	btn2_time_color.start()


func _on_Timer_for_color_timeout():
	print("timer 1 end")
	btn1.set_modulate(Color(0,1,0,0.5))
	btn1_time_reaction.start()
	start_epoch = OS.get_ticks_msec() 
	btn1_time_color.stop()
	



func _on_Button1_pressed():
	if btn1.get_modulate() == Color(1,0,0,0.5): #if user press when red
			btn1.text = str("Press only when green")
	else:
		current_epoch = OS.get_ticks_msec()
		elapsed_time = current_epoch - start_epoch
		btn1.set_modulate(Color(1,0,0,0.5)) #set back to red
		avg_time = ((elapsed_time+elapsed_time2)/2)
		time_total.text = str(avg_time) + "msec"


func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ReactionGame/ReactionGameInstructionPage.tscn")

func _on_Timer2_for_color_timeout():
	print("timer 2 end")
	btn2.set_modulate(Color(0,1,0,0.5))
	btn2_time_reaction.start()
	start_epoch2 = OS.get_ticks_msec() 
	btn2_time_color.stop()



func _on_Button2_pressed():

	if btn2.get_modulate() == Color(1,0,0,0.5): #if user press when red
		btn2.text = str("Press only when green")
	else:
		current_epoch2 = OS.get_ticks_msec()
		elapsed_time2 = current_epoch2 - start_epoch2
		btn2.set_modulate(Color(1,0,0,0.5)) #set back to red
		avg_time = ((elapsed_time+elapsed_time2)/2)
		time_total.text = str(avg_time) + "msec"
		




