extends Node

var scLog = preload("res://Script/sc_log.gd").new()


func user_add(id:String, pay:int, line:int, etc:Array=[]) -> void:
	ScGb.user[id] = str(pay)+" "+str(line)
	scLog.log_add("User;"+id+" Created. (PAY:"+str(pay)+", LINE:"+str(line)+")")

func user_del(id:String) -> void:
	ScGb.user.erase(id)
	scLog.log_add("User;"+id+" Delected.")

func user_reset() -> void:
	ScGb.user = {}

func user_find() -> void:
	scLog.log_add("ScGb Values List ↓")
	print(ScGb.user)
