extends Node


#This script is used for any variables that needs to be passed from one scene to the other.
#When using this script, please comment which scenes/files uses the variables


#Changed in MemoryGameInstructionPage and used in MemoryGame
var MemoryGameDifficulty = 0
var ObservationGameDifficulty = 0
var ReactionGameDifficulty = 0

# JudgementGameInstructionPage passes this constant to Board to set board size
var JudgementGameDifficulty = 3

#Statistics / Profile variables
var email : String # to pass user's email
var age : String # to pass user's age
var name_of_user : String # to pass user's name

func _ready():
	pass 
