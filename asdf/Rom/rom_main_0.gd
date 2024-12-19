extends Node2D
#Load Sys
var scUser = preload("res://Script/sc_user.gd").new()
var scLog = preload("res://Script/sc_log.gd").new()
var rand = RandomNumberGenerator.new()
#Create Var
var winer:Array = []
var start:bool = false
var die:bool = false
#Create Sys-Var
var debug:bool = false
var pNum:int = 5
var batting:bool = false
var battingNow:Array = [0,0,0,0,0]

func _ready() -> void:
	#scUser.user_add("2401권준",10000,1)
	pass


func _process(delta: float) -> void:
	var time = Time.get_datetime_dict_from_system()
	if start:
		for i in range(5):
			var target = get_node("obj_player"+str(i))
			if target.stat == 0:
				target.spd = rand.randf_range(0,2)
				if rand.randi_range(0,99) == 0: #10%
					var x = rand.randi_range(1,2)
					if x == 1:
						target.get_node("sprite").material.shader = preload("res://Shader/sh_fast.gdshader")
					else:
						target.get_node("sprite").material.shader = preload("res://Shader/sh_slow.gdshader")
					target.stat = x
				if (not die) and rand.randi_range(0,999) == 0: #0.1%
					target.stat = 3
					target.spd = 0
					die = true
					target.get_node("sprite").material.shader = preload("res://Shader/sh_die.gdshader")
					winer.push_back(target.line)
			elif target.stat != 3:
				if target.stat == 4:
					target.spd = 0
				elif target.stat == 1:
					target.spd = rand.randf_range(1,4)
				elif target.stat == 2:
					target.spd = rand.randf_range(0,1)
					
				if target.stat != 4 and rand.randi_range(0,9) == 0: #10%
					target.stat = 0
					target.get_node("sprite").material.shader = null
	elif Input.is_action_just_pressed("cu_f5"):
		scLog.log_add("Game Started.")
		start = true
	
	#Shout-Key Cheak	
	if Input.is_action_just_pressed("cu_f1"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif Input.is_action_just_pressed("cu_f2"):
		debug = !debug
		if debug:
			get_node("Label_sys0").visible = true
			$LineEdit.visible = true
		else:
			get_node("Label_sys0").visible = false
			$LineEdit.visible = false
	if Input.is_action_just_pressed("cu_f6"):
		print("ddd")
		var inst = load("res://Rom/rom_main.tscn").instantiate()
		get_parent().add_child(inst)
		queue_free()
	
	if len(winer) > 0:
		for i in range(4, 4-len(winer), -1):
			if i == 4:
				get_node("Label_rank/Label"+str(i)).text = str(winer[4-i]+1)+"번 달팽이(사망)"
			else:
				get_node("Label_rank/Label"+str(i)).text = str(winer[4-i]+1)+"번 달팽이"
	if debug:
		get_node("Label_sys0").text = "달팽이 수: "+str(pNum)+"(F3:증가/F4:감소/MAX:5)"


func _on_line_edit_text_submitted(new_text: String) -> void:
	var temp = new_text.split(" ")
	if temp[0] == "push":
		scUser.user_add(temp[1],int(float(temp[2])),int(float(temp[3])))
	elif temp[0] == "pop":
		scUser.user_del(temp[1])
	elif temp[0] == "reset":
		scUser.user_reset()
	elif temp[0] == "find":
		scUser.user_find()
	$LineEdit.text = ""
