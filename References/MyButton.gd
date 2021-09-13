extends Button

onready var label = $Label

var counter : int = 0
signal clicked_button

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Hello boiii!"
	label.text = "sup boiii"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MyButton_pressed():
	update_button_counter()
	emit_signal("clicked_button")


func update_button_counter():
	counter += 1
	text = str(counter)
