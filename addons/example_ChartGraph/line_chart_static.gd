extends Control

var document_EasyTask : FirestoreTask 
var documentEasy: FirestoreDocument
var document_NormalTask : FirestoreTask 
var documentNormal: FirestoreDocument 
var document_HardTask : FirestoreTask 
var documentHard: FirestoreDocument 
var firestore_collection : FirestoreCollection
var firestore_collection2 : FirestoreCollection
var currentTime
var player_email
var Easy1
var Normal1
var Hard1
var chartType

onready var chart_node = get_node('chart')

func _ready():
	chart_node.initialize(chart_node.LABELS_TO_SHOW.NO_LABEL,
	{
		Easy = Color(0.0, 1.0, 0.0),
		Normal = Color(1.0, 1.0, 0.0),
		Hard = Color(1.0, 0.0, 0.0),
	})
	Memory()
	chart_node.set_labels(7)
	set_process(true)

func Memory():
	chart_node.self_clear_chart()
	#data start
	player_email = GlobalScript.email
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/MScore")
	document_EasyTask = firestore_collection.get("Easy")
	documentEasy= yield(document_EasyTask, "get_document")
	document_NormalTask = firestore_collection.get("Normal")
	documentNormal= yield(document_NormalTask, "get_document")
	document_HardTask = firestore_collection.get("Hard")
	documentHard= yield(document_HardTask, "get_document")
	
	var index = str(1)
	
	if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
		Normal1 = 0
	else:
		Normal1 = int((documentNormal.doc_fields.get('Score'+index).split(",")[0]))
		
	if (int((documentHard.doc_fields.get('SumScore'))) == 0):
		Hard1 = 0
	else:
		Hard1 = int((documentHard.doc_fields.get('Score'+index).split(",")[0]))

	#data end
	var EasynoOfTimes= int(documentEasy.doc_fields.get('NoOfTimesPlayed'))
	var NormalnoOfTimes= int(documentNormal.doc_fields.get('NoOfTimesPlayed'))
	var HardnoOfTimes= int(documentHard.doc_fields.get('NoOfTimesPlayed'))
	
	var MostTimes = 0
	if EasynoOfTimes>= MostTimes:
		MostTimes=EasynoOfTimes
	if NormalnoOfTimes>= MostTimes:
		MostTimes=NormalnoOfTimes
	if HardnoOfTimes>= MostTimes:
		MostTimes=HardnoOfTimes

	for i in range(1,MostTimes+1):
		if (int((documentEasy.doc_fields.get('SumScore'))) == 0):
			Easy1 = 0
		elif i<=EasynoOfTimes:
			Easy1 = int(documentEasy.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Easy1 = 0

		if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
			Normal1 = 0
		elif i<=NormalnoOfTimes:
			Normal1 = int(documentNormal.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Normal1 = 0
		if (int((documentHard.doc_fields.get('SumScore'))) == 0):
			Hard1 = 0
		elif i<=HardnoOfTimes:
			Hard1 = int(documentHard.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Hard1 = 0
			
		chart_node.create_new_point({
		label = str(i),
		values = {
			Easy = Easy1,
			Normal = Normal1,
			Hard = Hard1
		}
	})
	
func Observation():
	#data start
	chart_node.self_clear_chart()
	player_email = GlobalScript.email
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/OScore")
	document_EasyTask = firestore_collection.get("Easy")
	documentEasy= yield(document_EasyTask, "get_document")
	document_NormalTask = firestore_collection.get("Normal")
	documentNormal= yield(document_NormalTask, "get_document")
	document_HardTask = firestore_collection.get("Hard")
	documentHard= yield(document_HardTask, "get_document")
	
	var index = str(1)
	
	if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
		Normal1 = 0
	else:
		Normal1 = int((documentNormal.doc_fields.get('Score'+index).split(",")[0]))
		
	if (int((documentHard.doc_fields.get('SumScore'))) == 0):
		Hard1 = 0
	else:
		Hard1 = int((documentHard.doc_fields.get('Score'+index).split(",")[0]))

	#data end
	var EasynoOfTimes= int(documentEasy.doc_fields.get('NoOfTimesPlayed'))
	var NormalnoOfTimes= int(documentNormal.doc_fields.get('NoOfTimesPlayed'))
	var HardnoOfTimes= int(documentHard.doc_fields.get('NoOfTimesPlayed'))
	
	var MostTimes = 0
	if EasynoOfTimes>= MostTimes:
		MostTimes=EasynoOfTimes
	if NormalnoOfTimes>= MostTimes:
		MostTimes=NormalnoOfTimes
	if HardnoOfTimes>= MostTimes:
		MostTimes=HardnoOfTimes

	for i in range(1,MostTimes+1):
		if (int((documentEasy.doc_fields.get('SumScore'))) == 0):
			Easy1 = 0
		elif i<=EasynoOfTimes:
			Easy1 = int(documentEasy.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Easy1 = 0

		if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
			Normal1 = 0
		elif i<=NormalnoOfTimes:
			Normal1 = int(documentNormal.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Normal1 = 0
		if (int((documentHard.doc_fields.get('SumScore'))) == 0):
			Hard1 = 0
		elif i<=HardnoOfTimes:
			Hard1 = int(documentHard.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Hard1 = 0
			
		chart_node.create_new_point({
		label = str(i),
		values = {
			Easy = Easy1,
			Normal = Normal1,
			Hard = Hard1
		}
	})
	
func Reaction():
	#data start
	chart_node.self_clear_chart()
	player_email = GlobalScript.email
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/RScore")
	document_EasyTask = firestore_collection.get("Easy")
	documentEasy= yield(document_EasyTask, "get_document")
	document_NormalTask = firestore_collection.get("Normal")
	documentNormal= yield(document_NormalTask, "get_document")
	document_HardTask = firestore_collection.get("Hard")
	documentHard= yield(document_HardTask, "get_document")
	
	var index = str(1)
	
	if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
		Normal1 = 0
	else:
		Normal1 = int((documentNormal.doc_fields.get('Score'+index).split(",")[0]))
		
	if (int((documentHard.doc_fields.get('SumScore'))) == 0):
		Hard1 = 0
	else:
		Hard1 = int((documentHard.doc_fields.get('Score'+index).split(",")[0]))

	#data end
	var EasynoOfTimes= int(documentEasy.doc_fields.get('NoOfTimesPlayed'))
	var NormalnoOfTimes= int(documentNormal.doc_fields.get('NoOfTimesPlayed'))
	var HardnoOfTimes= int(documentHard.doc_fields.get('NoOfTimesPlayed'))
	
	var MostTimes = 0
	if EasynoOfTimes>= MostTimes:
		MostTimes=EasynoOfTimes
	if NormalnoOfTimes>= MostTimes:
		MostTimes=NormalnoOfTimes
	if HardnoOfTimes>= MostTimes:
		MostTimes=HardnoOfTimes

	for i in range(1,MostTimes+1):
		if (int((documentEasy.doc_fields.get('SumScore'))) == 0):
			Easy1 = 0
		elif i<=EasynoOfTimes:
			Easy1 = int(documentEasy.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Easy1 = 0

		if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
			Normal1 = 0
		elif i<=NormalnoOfTimes:
			Normal1 = int(documentNormal.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Normal1 = 0
		if (int((documentHard.doc_fields.get('SumScore'))) == 0):
			Hard1 = 0
		elif i<=HardnoOfTimes:
			Hard1 = int(documentHard.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Hard1 = 0
			
		chart_node.create_new_point({
		label = str(i),
		values = {
			Easy = Easy1,
			Normal = Normal1,
			Hard = Hard1
		}
	})	
	
func Judgement():
	chart_node.self_clear_chart()
	#data start
	player_email = GlobalScript.email
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+"/JScore")
	document_EasyTask = firestore_collection.get("Easy")
	documentEasy= yield(document_EasyTask, "get_document")
	document_NormalTask = firestore_collection.get("Normal")
	documentNormal= yield(document_NormalTask, "get_document")
	document_HardTask = firestore_collection.get("Hard")
	documentHard= yield(document_HardTask, "get_document")
	
	var index = str(1)
	
	if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
		Normal1 = 0
	else:
		Normal1 = int((documentNormal.doc_fields.get('Score'+index).split(",")[0]))
		
	if (int((documentHard.doc_fields.get('SumScore'))) == 0):
		Hard1 = 0
	else:
		Hard1 = int((documentHard.doc_fields.get('Score'+index).split(",")[0]))

	#data end
	var EasynoOfTimes= int(documentEasy.doc_fields.get('NoOfTimesPlayed'))
	var NormalnoOfTimes= int(documentNormal.doc_fields.get('NoOfTimesPlayed'))
	var HardnoOfTimes= int(documentHard.doc_fields.get('NoOfTimesPlayed'))
	
	var MostTimes = 0
	if EasynoOfTimes>= MostTimes:
		MostTimes=EasynoOfTimes
	if NormalnoOfTimes>= MostTimes:
		MostTimes=NormalnoOfTimes
	if HardnoOfTimes>= MostTimes:
		MostTimes=HardnoOfTimes

	for i in range(1,MostTimes+1):
		if (int((documentEasy.doc_fields.get('SumScore'))) == 0):
			Easy1 = 0
		elif i<=EasynoOfTimes:
			Easy1 = int(documentEasy.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Easy1 = 0

		if (int((documentNormal.doc_fields.get('SumScore'))) == 0):
			Normal1 = 0
		elif i<=NormalnoOfTimes:
			Normal1 = int(documentNormal.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Normal1 = 0
		if (int((documentHard.doc_fields.get('SumScore'))) == 0):
			Hard1 = 0
		elif i<=HardnoOfTimes:
			Hard1 = int(documentHard.doc_fields.get('Score'+str(i)).split(",")[0])
		else:
			Hard1 = 0
			
		chart_node.create_new_point({
		label = str(i),
		values = {
			Easy = Easy1,
			Normal = Normal1,
			Hard = Hard1
		}
	})
	
