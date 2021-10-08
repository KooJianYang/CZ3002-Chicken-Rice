extends Control

var is_started = false
var game_won = false
var start_epoch
var current_epoch

onready var board = $MarginContainer/VBoxContainer/GameView/Board

onready var overlay = $MarginContainer/VBoxContainer/GameView/StartOverlay
onready var overlay_text = $MarginContainer/VBoxContainer/GameView/StartOverlay/TextOverlay

onready var move_value = $MarginContainer/VBoxContainer/StatsView/HBoxContainer/Moves/MoveValue
onready var timer_value = $MarginContainer/VBoxContainer/StatsView/HBoxContainer/Time/TimeValue

onready var anim_player = $AnimationPlayer
func _ready():
	overlay.visible = true

func _process(_delta):
	if is_started:
		current_epoch = OS.get_ticks_msec()
		var time_since_game_start = current_epoch - start_epoch
		timer_value.text = str(floor(time_since_game_start/1000)) + '.' + str(floor(fmod(time_since_game_start, 1000)/10)) + 's'
	else:
		if not game_won:
			timer_value.text = '0.00s'

func _on_Board_game_started():
	if game_won:
		return
	start_epoch = OS.get_ticks_msec()
	overlay.visible = false
	is_started = true
	game_won = false


func _on_Board_game_won():
	overlay_text.text = 'Nice Work!\n Click Restart to play again'
	overlay.visible = true
	is_started = false
	game_won = true
	var time_since_game_start = current_epoch - start_epoch
	print("time taken = ", floor(time_since_game_start/1000), "s")
	print("moves = ", board.move_count)


func _on_RestartButton_pressed():
	if not is_started and not game_won:
		print("restart aint working")
		return
	is_started = true
	overlay.visible = false
	game_won = false
	board.reset_move_count()
	board.scramble_board()
	board.game_state = board.GAME_STATES.STARTED
	start_epoch = OS.get_ticks_msec()
	


func _on_Board_moves_updated(move_count):
	if not is_started:
		return
	move_value.text = str(move_count)


func _on_SettingsScreen_board_size_update(new_size):
	board.update_size(new_size)
	overlay_text.text = 'Click to start'
	overlay.visible = true
	is_started = false


func _on_SettingsScreen_show_numbers_update(state):
	board.set_tile_numbers(state)


func _on_SettingsButton_pressed():
	anim_player.play("show_settings")


func _on_SettingsScreen_hide_settings():
	anim_player.play_backwards("show_settings")


func _on_SettingsScreen_background_update(texture: ImageTexture):
	print('updating background texture now')
	board.update_background_texture(texture)


func _on_BackButton_pressed():
	var _error = get_tree().change_scene("res://UI Pages/InstructionPages/JudgementGame/JudgementGameInstructionPage.tscn")
