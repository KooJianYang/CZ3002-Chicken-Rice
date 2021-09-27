extends Control

export (PackedScene) onready var circle
export (PackedScene) onready var line_to_connect_circles
onready var lines : Node2D = $Lines
var circle_dimensions : Vector2
var pressed_circles : Array 
var circles_to_connect : Array = [1, 2]
signal connected_all_circles


func _ready() -> void:
	set_up_circle_dimensions()
	

# circle dimensions is needed to find max x and y position that the circle can be spawned
func set_up_circle_dimensions() -> void: 
	var current_circle : ObservationGameCircle = circle.instance()
	circle_dimensions.x = current_circle.rect_size.x
	circle_dimensions.y = current_circle.rect_size.y
	current_circle.queue_free()


func spawn_circles(number_of_circles : int) -> void:
	for current_circle_index in range(number_of_circles):
		var current_circle : ObservationGameCircle = circle.instance()
		add_child(current_circle)
		current_circle.connect("pressed_circle", self, "on_pressed_circle")
		current_circle.connect("released_circle", self, "on_released_circle")
		var found_position_to_spawn : bool = false
		while !found_position_to_spawn:
			spawn_circle_at_random_position(current_circle)
			yield(get_tree(), "physics_frame") # this is needed as get_overlapping areas is only updated after a physics frame
			if current_circle.proximity_area.get_overlapping_areas().empty():
				found_position_to_spawn = true
				current_circle.update_label_number(current_circle_index + 1)


func on_pressed_circle(pressed_circle : ObservationGameCircle) -> void:
	pressed_circles.append(pressed_circle)
	if pressed_circles.size() == 2:
		var circles_are_neighbours : bool = check_if_circles_are_neighbours(pressed_circles[0], pressed_circles[1])
		var circles_are_to_be_connected : bool = check_if_circles_are_to_be_connected(pressed_circles[0], pressed_circles[1])
		if circles_are_neighbours and circles_are_to_be_connected:
			connect_circles_with_line(pressed_circles[0], pressed_circles[1])
			update_circles_to_connect()
		reset_circles_state()
		pressed_circles.clear()


func on_released_circle(released_circle : ObservationGameCircle) -> void:
	pressed_circles.erase(released_circle)

			
func check_if_circles_are_neighbours(circle_1 : ObservationGameCircle, circle_2 : ObservationGameCircle) -> bool:
	return(abs(circle_1.get_label_number() - circle_2.get_label_number()) == 1) 


func check_if_circles_are_to_be_connected(circle_1 : ObservationGameCircle, circle_2 : ObservationGameCircle) -> bool:
	var circles_matched : int = 0
	for i in range(circles_to_connect.size()):
		if circle_1.get_label_number() == circles_to_connect[i]:
			circles_matched += 1
		if circle_2.get_label_number() == circles_to_connect[i]:
			circles_matched += 1
	return(circles_matched == 2)
	

func update_circles_to_connect() -> void:
	for i in range(circles_to_connect.size()):
		circles_to_connect[i] += 1
	var all_circles_connected : bool = circles_to_connect[0] == 25
	if all_circles_connected:
		emit_signal("connected_all_circles")
		

func connect_circles_with_line(circle_1 : ObservationGameCircle, circle_2 : ObservationGameCircle) -> void:
	var new_line : Line2D = line_to_connect_circles.instance()
	lines.add_child(new_line)
	new_line.points[0] = circle_1.rect_position + circle_1.rect_pivot_offset
	new_line.points[1] = circle_2.rect_position + circle_2.rect_pivot_offset


func reset_circles_state() -> void:
	for i in pressed_circles.size():
		pressed_circles[i].recover_from_contract()
		pressed_circles[i].pressed = false


func spawn_circle_at_random_position(current_circle : ObservationGameCircle) -> void:
	current_circle.rect_position = get_random_position_on_screen()


func get_random_position_on_screen() -> Vector2:
	var screen_dimensions : Vector2 = get_viewport_rect().size # (width, height)
	var max_x_position : float = screen_dimensions.x - circle_dimensions.x
	var max_y_position : float = screen_dimensions.y - circle_dimensions.y
	randomize()
	return Vector2(rand_range(0, max_x_position), rand_range(0, max_y_position))
