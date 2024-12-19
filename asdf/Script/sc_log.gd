extends Node


func log_add(str:String) -> String:
	var time = Time.get_datetime_dict_from_system()
	var lg = "["+str(time.hour)+":"+str(time.minute)+":"+str(time.second)+"] "+str
	print(lg)
	return lg
