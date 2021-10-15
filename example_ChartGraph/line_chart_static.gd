extends Control


onready var chart_node = get_node('chart')

func _ready():
	chart_node.initialize(chart_node.LABELS_TO_SHOW.NO_LABEL,
	{
		Memory = Color(1.0, 0.18, 0.18),
		Judgement = Color(0.58, 0.92, 0.07),
		Observation = Color(0.5, 0.22, 0.6),
		Reaction = Color(0.15, 0.5, 0.6)
	})
	chart_node.set_labels(7)
	reset()
	set_process(true)

func reset():
	chart_node.create_new_point({
		label = '1',
		values = {
			Memory = 5,
			Judgement = 2,
			Observation = 3,
			Reaction = 2
		}
	})

	chart_node.create_new_point({
		label = '2',
		values = {
			Memory = 6,
			Judgement = 4,
			Observation = 25,
			Reaction = 15
		}
	})

	chart_node.create_new_point({
		label = '3',
		values = {
			Memory = 2,
			Judgement = 15,
			Observation = 40,
			Reaction = 30
		}
	})

	chart_node.create_new_point({
		label = '4',
		values = {
			Memory = 30,
			Judgement = 70,
			Observation = 09,
			Reaction = 70
		}
	})

	chart_node.create_new_point({
		label = '5',
		values = {
			Memory = 13,
			Judgement = 70,
			Observation = 10
		}
	})

	chart_node.create_new_point({
		label = '6',
		values = {
			Memory = 30,
			Judgement = 50,
			Observation = 20
		}
	})
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	#func _process(delta):
	#	pass
	
	
	#func reset():
	#	chart_node.create_new_point({
	#		label = 'January',
	#		values = {
	#			stock1 = 500,
	#			stock2 = 200,
	#			stock3 = 300
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'February',
	#		values = {
	#			stock1 = 600,
	#			stock2 = 400,
	#			stock3 = -250
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'March',
	#		values = {
	#			stock1 = 2000,
	#			stock2 = 1575,
	#			stock3 = -450
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'April',
	#		values = {
	#			stock1 = 350,
	#			stock2 = 750,
	#			stock3 = -509
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'May',
	#		values = {
	#			stock1 = 1350,
	#			stock2 = 750,
	#			stock3 = -100
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'June',
	#		values = {
	#			stock1 = 350,
	#			stock2 = 1750,
	#			stock3 = -250
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'July',
	#		values = {
	#			stock1 = 100,
	#			stock2 = 1500,
	#			stock3 = -50
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'August',
	#		values = {
	#			stock1 = 350,
	#			stock2 = 750,
	#			stock3 = -100
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'September',
	#		values = {
	#			stock1 = 1350,
	#			stock2 = 750,
	#			stock3 = -50
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'October',
	#		values = {
	#			stock1 = 350,
	#			stock2 = 2750,
	#			stock3 = 100
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'November',
	#		values = {
	#			stock1 = 450,
	#			stock2 = 200,
	#			stock3 = 150
	#		}
	#	})
	#
	#	chart_node.create_new_point({
	#		label = 'December',
	#		values = {
	#			stock1 = 1350,
	#			stock2 = 500,
	#			stock3 = 200
	#		}
	#	})
	
