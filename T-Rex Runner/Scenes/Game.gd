extends Control

onready var Trex = $TRex
onready var time = Global.timer
onready var SpriteResource =  preload("res://Scenes/Floorsprite.tscn")

var previous_time = 0

func _ready() -> void:
	#colour palette
	$TextureRect.color = Color(Global.background_colour)
	$Pauser/Container/HighscoreBG.color = Color(Global.background_colour)
	for i in get_tree().get_nodes_in_group("modulate3"):
		i.set("custom_colors/font_color", Color(Global.sprite_colour))
	for i in get_tree().get_nodes_in_group("self_modulate"):
		i.set("self_modulate", Color(Global.sprite_colour))
	
	#reinitialize variables
	$Pauser.paused = false
	$Pauser/VBoxContainer/StartText.visible = true
	
	#check for restart
	if Global.is_restart == true:
		$Pauser/VBoxContainer/StartText.text = "Game Restart"


func _process(delta: float) -> void:
	time += delta
	if time - previous_time > 5:
		update_score()
		previous_time = time 
	match Global.difficulty:
		"easy":
			if Engine.time_scale < 3 :
				Engine.time_scale = 1 + (1/30.0) * time
		"medium":
			if Engine.time_scale < 6 :
				Engine.time_scale = 2 + (1/30.0) * time
		"hard":
			if Engine.time_scale < 9 :
				Engine.time_scale = 3 + (1/30.0) * time
	#print(Engine.time_scale)


func update_score() -> void:
	Global.score += 1 
	$Score.text = "Score: " + str(Global.score)
	
#	print("score" + str(Global.score))
#	print("1st"+ str(Global.highest_score))
#	print("2nd" + str(Global.second_highest_score))
#	print("3rd" + str(Global.third_highest_score))
#	print(Global.timer)
#	print(Engine.time_scale)

func _on_Timer_timeout() -> void:
	$Pauser/VBoxContainer/StartText/AnimationPlayer.current_animation = "disappear"
	yield( $Pauser/VBoxContainer/StartText/AnimationPlayer, "animation_finished")
	$Pauser/VBoxContainer/StartText.visible = false
