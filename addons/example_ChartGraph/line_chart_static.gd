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
var Easy1=0
var Normal1=0
var Hard1=0
var chartType
var temp


onready var chart_node = get_node('chart')

func _ready():
	chart_node.initialize(chart_node.LABELS_TO_SHOW.NO_LABEL,
	{
		Easy = Color(0.0, 0.5, 0.0),
		Normal = Color(1.0, 1.0, 0.0),
		Hard = Color(1.0, 0.0, 0.0),
	})
	Stats("/MScore")
	chart_node.set_labels(7)
	set_process(true)

func MemoryOri():
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
	
func ObservationOri():
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
	
func ReactionOri():
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
	
func JudgementOri():
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
	
func Stats(Gametype):
	chart_node.self_clear_chart()
	player_email = GlobalScript.email
	firestore_collection  = Firebase.Firestore.collection("userdata/"+player_email+Gametype)
	document_EasyTask = firestore_collection.get("Easy")
	documentEasy= yield(document_EasyTask, "get_document")
	document_NormalTask = firestore_collection.get("Normal")
	documentNormal= yield(document_NormalTask, "get_document")
	document_HardTask = firestore_collection.get("Hard")
	documentHard= yield(document_HardTask, "get_document")

	var EasynoOfTimes= int(documentEasy.doc_fields.get('NoOfTimesPlayed'))
	var NormalnoOfTimes= int(documentNormal.doc_fields.get('NoOfTimesPlayed'))
	var HardnoOfTimes= int(documentHard.doc_fields.get('NoOfTimesPlayed'))
	var JanCountEasy = 0
	var FebCountEasy = 0
	var MarCountEasy = 0
	var AprCountEasy = 0
	var MayCountEasy = 0
	var JunCountEasy = 0
	var JulCountEasy = 0
	var AugCountEasy = 0
	var SepCountEasy = 0
	var OctCountEasy = 0
	var NovCountEasy = 0
	var DecCountEasy = 0
	var JanCountNorm = 0
	var FebCountNorm = 0
	var MarCountNorm = 0
	var AprCountNorm = 0
	var MayCountNorm = 0
	var JunCountNorm = 0
	var JulCountNorm = 0
	var AugCountNorm = 0
	var SepCountNorm = 0
	var OctCountNorm = 0
	var NovCountNorm = 0
	var DecCountNorm = 0
	var JanCountHard = 0
	var FebCountHard = 0
	var MarCountHard = 0
	var AprCountHard = 0
	var MayCountHard = 0
	var JunCountHard = 0
	var JulCountHard = 0
	var AugCountHard = 0
	var SepCountHard = 0
	var OctCountHard = 0
	var NovCountHard = 0
	var DecCountHard = 0
	var JanEasy = 0
	var JanNorm = 0
	var JanHard = 0
	var FebEasy = 0
	var FebNorm = 0
	var FebHard = 0
	var MarEasy = 0
	var MarNorm = 0
	var MarHard = 0
	var AprEasy = 0
	var AprNorm = 0
	var AprHard = 0
	var MayEasy = 0
	var MayNorm = 0
	var MayHard = 0
	var JunEasy = 0
	var JunNorm = 0
	var JunHard = 0
	var JulEasy = 0
	var JulNorm = 0
	var JulHard = 0
	var AugEasy = 0
	var AugNorm = 0
	var AugHard = 0
	var SepEasy = 0
	var SepNorm = 0
	var SepHard = 0
	var OctEasy = 0
	var OctNorm = 0
	var OctHard = 0
	var NovEasy = 0
	var NovNorm = 0
	var NovHard = 0
	var DecEasy = 0
	var DecNorm = 0
	var DecHard = 0
	
	for i in range(1,13):
		if(documentEasy.doc_fields.get(('Score'+str(i)))!=null):
			for u in range(1,EasynoOfTimes+1):
				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '01'):
					JanCountEasy+=1
					JanEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '02'):
					FebCountEasy+=1
					FebEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '03'):
					MarCountEasy+=1
					MarEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '04'):
					AprCountEasy+=1
					AprEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '05'):
					MayCountEasy+=1
					MayEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '06'):
					JunCountEasy+=1
					JunEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '07'):
					JulCountEasy+=1
					JulEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '08'):
					AugCountEasy+=1
					AugEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])
					
				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '09'):
					SepCountEasy+=1
					SepEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '10'):
					OctCountEasy+=1
					OctEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '11'):
					NovCountEasy+=1
					NovEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentEasy.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '12'):
					DecCountEasy+=1
					DecEasy += int(documentEasy.doc_fields.get('Score'+ str(u)).split(",")[0])

		if(documentNormal.doc_fields.get(('Score'+str(i)))!=null):
			for u in range(1,NormalnoOfTimes+1):
				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '01'):
					JanCountNorm+=1
					JanNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '02'):
					FebCountNorm+=1
					FebNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '03'):
					MarCountNorm+=1
					MarNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '04'):
					AprCountNorm+=1
					AprNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '05'):
					MayCountNorm+=1
					MayNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '06'):
					JunCountNorm+=1
					JunNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '07'):
					JulCountNorm+=1
					JulNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '08'):
					AugCountNorm+=1
					AugNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])
					
				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '09'):
					SepCountNorm+=1
					SepNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '10'):
					OctCountNorm+=1
					OctNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '11'):
					NovCountNorm+=1
					NovNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentNormal.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '12'):
					DecCountNorm+=1
					DecNorm += int(documentNormal.doc_fields.get('Score'+ str(u)).split(",")[0])

		if(documentHard.doc_fields.get(('Score'+str(i)))!=null):
			for u in range(1,HardnoOfTimes+1):
				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '01'):
					JanCountHard+=1
					JanHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '02'):
					FebCountHard+=1
					FebHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '03'):
					MarCountHard+=1
					MarHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '04'):
					AprCountHard+=1
					AprHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '05'):
					MayCountHard+=1
					MayHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '06'):
					JunCountHard+=1
					JunHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '07'):
					JulCountHard+=1
					JulHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '08'):
					AugCountHard+=1
					AugHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])
					
				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '09'):
					SepCountHard+=1
					SepHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '10'):
					OctCountHard+=1
					OctHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '11'):
					NovCountHard+=1
					NovHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

				if(documentHard.doc_fields.get(('Score'+str(u)).split(",")[0]).split("/")[1] == '12'):
					DecCountHard+=1
					DecHard += int(documentHard.doc_fields.get('Score'+ str(u)).split(",")[0])

	if JanEasy != 0 or JanCountEasy != 0:
		JanEasy/= JanCountEasy
	else:
		JanEasy=0

	if FebEasy != 0 or FebCountEasy != 0:
		FebEasy/= FebCountEasy
	else:
		FebEasy=0

	if MarEasy != 0 or MarCountEasy != 0:
		MarEasy/= MarCountEasy
	else:
		MarEasy=0

	if AprEasy != 0 or AprCountEasy != 0:
		AprEasy/= AprCountEasy
	else:
		AprEasy=0

	if MayEasy != 0 or MayCountEasy != 0:
		MayEasy/= MayCountEasy
	else:
		MayEasy=0

	if JunEasy != 0 or JunCountEasy != 0:
		JunEasy/= JunCountEasy
	else:
		JunEasy=0

	if JulEasy != 0 or JulCountEasy != 0:
		JulEasy/= JulCountEasy
	else:
		JulEasy=0

	if AugEasy != 0 or AugCountEasy != 0:
		AugEasy/= AugCountEasy
	else:
		AugEasy=0

	if SepEasy != 0 or SepCountEasy != 0:
		SepEasy/= SepCountEasy
	else:
		SepEasy=0

	print("1-",OctEasy)
	if OctEasy != 0 or OctCountEasy != 0:
		OctEasy/= OctCountEasy
	else:
		OctEasy=0
	print("2-",OctEasy)
	if NovEasy != 0 or NovCountEasy != 0:
		NovEasy/= NovCountEasy
	else:
		NovEasy=0

	if DecEasy != 0 or DecCountEasy != 0:
		DecEasy/= DecCountEasy
	else:
		DecEasy=0

	if JanNorm != 0 or JanCountNorm != 0:
		JanNorm/= JanCountNorm
	else:
		JanNorm=0

	if FebNorm != 0 or FebCountNorm != 0:
		FebNorm/= FebCountNorm
	else:
		FebNorm=0

	if MarNorm != 0 or MarCountNorm != 0:
		MarNorm/= MarCountNorm
	else:
		MarNorm=0

	if AprNorm != 0 or AprCountNorm != 0:
		AprNorm/= AprCountNorm
	else:
		AprNorm=0

	if MayNorm != 0 or MayCountNorm != 0:
		MayNorm/= MayCountNorm
	else:
		MayNorm=0

	if JunNorm != 0 or JunCountNorm != 0:
		JunNorm/= JunCountNorm
	else:
		JunNorm=0

	if JulNorm != 0 or JulCountNorm != 0:
		JulNorm/= JulCountNorm
	else:
		JulNorm=0

	if AugNorm != 0 or AugCountNorm != 0:
		AugNorm/= AugCountNorm
	else:
		AugNorm=0

	if SepNorm != 0 or SepCountNorm != 0:
		SepNorm/= SepCountNorm
	else:
		SepNorm=0

	if OctNorm != 0 or OctCountNorm != 0:
		OctNorm/= OctCountNorm
	else:
		OctNorm=0

	if NovNorm != 0 or NovCountNorm != 0:
		NovNorm/= NovCountNorm
	else:
		NovNorm=0

	if DecNorm != 0 or DecCountNorm != 0:
		DecNorm/= DecCountNorm
	else:
		DecNorm=0

	if JanHard != 0 or JanCountHard != 0:
		JanHard/= JanCountHard
	else:
		JanHard=0

	if FebHard != 0 or FebCountHard != 0:
		FebHard/= FebCountHard
	else:
		FebHard=0

	if MarHard != 0 or MarCountHard != 0:
		MarHard/= MarCountHard
	else:
		MarHard=0

	if AprHard != 0 or AprCountHard != 0:
		AprHard/= AprCountHard
	else:
		AprHard=0

	if MayHard != 0 or MayCountHard != 0:
		MayHard/= MayCountHard
	else:
		MayHard=0

	if JunHard != 0 or JunCountHard != 0:
		JunHard/= JunCountHard
	else:
		JunHard=0

	if JulHard != 0 or JulCountHard != 0:
		JulHard/= JulCountHard
	else:
		JulHard=0

	if AugHard != 0 or AugCountHard != 0:
		AugHard/= AugCountHard
	else:
		AugHard=0

	if SepHard != 0 or SepCountHard != 0:
		SepHard/= SepCountHard
	else:
		SepHard=0

	if OctHard != 0 or OctCountHard != 0:
		OctHard/= OctCountHard
	else:
		OctHard=0

	if NovHard != 0 or NovCountHard != 0:
		NovHard/= NovCountHard
	else:
		NovHard=0

	if DecHard != 0 or DecCountHard != 0:
		DecHard/= DecCountHard
	else:
		DecHard=0

		
	chart_node.create_new_point({
		label = 'January',
		values = {
			Easy = JanEasy,
			Normal = JanNorm,
			Hard = JanHard
		}
	})

	chart_node.create_new_point({
		label = 'February',
		values = {
			Easy = FebEasy,
			Normal = FebNorm,
			Hard = FebHard
		}
	})

	chart_node.create_new_point({
		label = 'March',
		values = {
			Easy = MarEasy,
			Normal = MarNorm,
			Hard = MarHard
		}
	})

	chart_node.create_new_point({
		label = 'April',
		values = {
			Easy = AprEasy,
			Normal = AprNorm,
			Hard = AprHard
		}
	})

	chart_node.create_new_point({
		label = 'May',
		values = {
			Easy = MayEasy,
			Normal = MayNorm,
			Hard = MayHard
		}
	})

	chart_node.create_new_point({
		label = 'June',
		values = {
			Easy = JunEasy,
			Normal = JunNorm,
			Hard = JunHard
		}
	})

	chart_node.create_new_point({
		label = 'July',
		values = {
			Easy = JulEasy,
			Normal = JulNorm,
			Hard = JulHard
		}
	})

	chart_node.create_new_point({
		label = 'August',
		values = {
			Easy = AugEasy,
			Normal = AugNorm,
			Hard = AugHard
		}
	})

	chart_node.create_new_point({
		label = 'September',
		values = {
			Easy = SepEasy,
			Normal = SepNorm,
			Hard = SepHard
		}
	})

	chart_node.create_new_point({
		label = 'October',
		values = {
			Easy = OctEasy,
			Normal = OctNorm,
			Hard = OctHard
		}
	})
	
	chart_node.create_new_point({
		label = 'November',
		values = {
			Easy = NovEasy,
			Normal = NovNorm,
			Hard = NovHard
		}
	})

	chart_node.create_new_point({
		label = 'December',
		values = {
			Easy = DecEasy,
			Normal = DecNorm,
			Hard = DecHard
		}
	})
