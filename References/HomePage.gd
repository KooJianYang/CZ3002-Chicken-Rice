extends Control

onready var my_button = get_node("MyButton")


# Called when the node enters the scene tree for the first time.
func _ready():
	my_button.connect("clicked_button", self, "update_home_page")


func update_home_page():
	print("updated")

