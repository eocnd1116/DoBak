extends CharacterBody2D

var scLog = preload("res://Script/sc_log.gd").new()
var rand = RandomNumberGenerator.new()
var pName:Array = ["","그냥","나약한","비실한","강인한","멋진","독","신용불량자","자신있는","거지","곧 죽는"]

@export var line:int = 0
var spd:int = 0
var stat:int = 0 #0:default / 1:fast / 2:slow / 3:die


func _ready() -> void:
	$Label.text = pName[rand.randi_range(0,len(pName)-1)] + " 달팽이"

func _process(delta: float) -> void:
	if get_parent().start:
		position.x += spd


func _on_solid_area_entered(area: Area2D) -> void:
	stat = 4
	spd = 0
	get_parent().winer.push_back(line)
	if len(get_parent().winer) > 4:
		scLog.log_add("Game Ended.")
		get_parent().start = false
		for i in range(5):
			scLog.log_add( str(i+1)+" - "+str(get_parent().winer[i])+"line player.")
		get_parent().get_node("Label_end").visible = true
		var result:String = ""
		
		print(ScGb.user)
		for item in ScGb.user:
			var temp = [int(float(ScGb.user[item].split(" ")[0])),get_parent().winer.find(int(float(ScGb.user[item].split(" ")[1])))]
			var temp2 = "몰수(0개 획득)"
			if temp[1] == 0:
				temp2 = "3배("+str(temp[0]*3)+"개 획득)"
			elif temp[1] == 1:
				temp2 = "2배("+str(temp[0]*2)+"개 획득)"
			result += item+" - "+str(temp[1]+1)+"등 "+temp2+"\n"
		get_parent().get_node("Label_end/Label_list").text = result
