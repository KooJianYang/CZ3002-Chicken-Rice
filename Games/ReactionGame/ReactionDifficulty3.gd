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

#button 3
onready var btn3 :=$Button3
onready var btn3_time_color :=$Button3/Timer3_for_color
onready var btn3_time_reaction :=$Button3/Timer3_for_reaction
var start_epoch3
var current_epoch3
var elapsed_time3 = 0

#stats 
onready var time_total :=$Statistics/Timer

#end game
onready var timeTaken = $GameEnd/GameEndContainer/TimeTaken
onready var end = $GameEnd

var rng= RandomNumberGenerator.new()
var avg_time = 0
var count = 0
var count2 = 0
var count3 = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	btn1.set_modulate(Color(1,0,0,0.5)) 
	btn2.set_modulate(Color(1,0,0,0.5))
	btn3.set_modulate(Color(1,0,0,0.5))
	end.visible = false
	random_time_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if count == 3 and count2 == 3 and count3 == 3:
		endGame()

func random_time_color():
	rng.randomize()
	btn1_time_color.set_wait_time(rng.randi_range(2,10))
	btn1_time_color.start()

	btn2_time_color.set_wait_time(rng.randi_range(2,10))
	btn2_time_color.start()
	
	btn3_time_color.set_wait_time(rng.randi_range(2,10))
	btn3_time_color.start()


func _on_Timer_for_color_timeout():
	btn1.set_modulate(Color(0,1,0,0.5))
	btn1_time_reaction.start()
	start_epoch = OS.get_ticks_msec() 
	if count>2:
		btn1_time_color.stop()
		btn1.set_modulate(Color(1,0,0,0.5))

func _on_Timer2_for_color_timeout():
	btn2.set_modulate(Color(0,1,0,0.5))
	btn2_time_reaction.start()
	start_epoch2 = OS.get_ticks_msec() 
	if count2>2:
		btn2_time_color.stop()
		btn2.set_modulate(Color(1,0,0,0.5))

func _on_Timer3_for_color_timeout():
	btn3.set_modulate(Color(0,1,0,0.5))
	btn3_time_reaction.start()
	start_epoch3 = OS.get_ticks_msec() 
	if count3>2:
		btn3_time_color.stop()
		btn3.set_modulate(Color(1,0,0,0.5))


func _on_Button1_pressed():
	if btn1.get_modulate() == Color(1,0,0,0.5): #if user press when red
			btn1.text = str("Press only when green")
	else:
		count += 1
		current_epoch = OS.get_ticks_msec()
		elapsed_time = current_epoch - start_epoch
		btn1.set_modulate(Color(1,0,0,0.5)) #set back to red
		avg_time = avg_time + elapsed_time

func _on_Button2_pressed():
	if btn2.get_modulate() == Color(1,0,0,0.5): #if user press when red
		btn2.text = str("Press only when green")
	else:
		count2 += 1
		current_epoch2 = OS.get_ticks_msec()
		elapsed_time2 = current_epoch2 - start_epoch2
		btn2.set_modulate(Color(1,0,0,0.5)) #set back to red
		avg_time = elapsed_time2 + avg_time

func _on_Button3_pressed():
	if btn3.get_modulate() == Color(1,0,0,0.5): #if user press when red
		btn2.text = str("Press only when green")
	else:
		count3 += 1
		current_epoch3 = OS.get_ticks_msec()
		elapsed_time3 = current_epoch3 - start_epoch3
		btn3.set_modulate(Color(1,0,0,0.5)) #set back to red
		avg_time = elapsed_time3 + avg_time


func _on_BackButton_pressed():
	get_tree().change_scene("res://UI Pages/InstructionPages/ReactionGame/ReactionGameInstructionPage.tscn")


func endGame():
	#time_total.text = str(avg_time/9)
	btn1.visible = false
	btn2.visible = false
	btn3.visible = false
	end.visible = true
	timeTaken.text = str(avg_time/9) + "milliseconds"







