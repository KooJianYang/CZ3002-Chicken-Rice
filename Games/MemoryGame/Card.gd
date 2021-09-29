extends TextureButton

class_name Card

var value
var face
var back

func _ready():
	set_h_size_flags(3)
	set_v_size_flags(3)
	set_expand(true)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)
		
func _init(var v):
	value = v
	face = load("res://Assets/MemoryGame/"+value+".png")
	back = load("res://Assets/MemoryGame/Back.png")
	set_normal_texture(back)
	
func _pressed():
	MemoryGameManager.chooseCard(self)
	
func flip():
	if get_normal_texture() == back:
		set_normal_texture(face)
	else:
		set_normal_texture(back)
