extends TextureButton
class_name ObservationGameCircle

onready var label_number = $LabelNumber
onready var proximity_area = $ProximityArea
onready var tween = $Tween
signal pressed_circle(circle_instance)
signal released_circle(circle_instance)


func update_label_number(number : int) -> void:
	label_number.text = str(number)


func get_label_number() -> int:
	return int(label_number.text)


func _on_Circle_pressed() -> void:
	if pressed:
		contract()
		emit_signal("pressed_circle", self)
	else:
		recover_from_contract()
		emit_signal("released_circle", self)
	

func contract() -> void:
	tween.interpolate_property(self, "rect_scale",
		Vector2(1, 1), Vector2(0.75, 0.75), 0.5,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()

func recover_from_contract() -> void:
	tween.interpolate_property(self, "rect_scale",
		Vector2(0.75, 0.75), Vector2(1, 1), 0.5,
		Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
