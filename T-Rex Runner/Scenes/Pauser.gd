extends Node

onready var scene_tree: SceneTree = get_tree()

var paused:= false setget set_paused

var defeated

signal die

func _unhandled_input(event: InputEvent) -> void:
	#handling inputs
	if Input.is_action_just_pressed("ui_pause") and $VBoxContainer/QuitText.visible == false:
		self.paused = not self.paused
		print("pause flipped" + str(self.paused))
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
		scene_tree.paused = false
		Global.is_restart = true
		Global.timer = 0
		Global.score = 0
		Engine.time_scale = 0
	
	if Input.is_action_pressed("quit"):
		Global.save_and_quit()

func set_paused(value: bool) -> void:
	paused = value
	print("pause mode" + str(value))	
	get_tree().paused = value
	$VBoxContainer/PauseText.visible = value
	if paused == true:
		$VBoxContainer/PauseText/AnimationPlayer.play("pulsate")
	if paused == false:
		$VBoxContainer/PauseText/AnimationPlayer.stop()


func _on_TRex_tree_exiting() -> void:
	#buffering the end screen after the TRex dies
	$Timer.start()


func _on_Timer_timeout() -> void:
	
	self.paused = true
	
	#final score tally
	if Global.score == Global.highest_score or Global.score == Global.second_highest_score or Global.score == Global.third_highest_score:
		pass
	elif Global.score > Global.highest_score:
		Global.third_highest_score = Global.second_highest_score
		Global.second_highest_score = Global.highest_score
		Global.highest_score = Global.score
	elif Global.score > Global.second_highest_score:
		Global.third_highest_score = Global.second_highest_score
		Global.second_highest_score = Global.score
	elif Global.score > Global.third_highest_score:
		Global.third_highest_score = Global.score
	match Global.difficulty:
		"easy": 
			Global.highest_score_easy = Global.highest_score
			Global.second_highest_score_easy = Global.second_highest_score 
			Global.third_highest_score_easy = Global.third_highest_score
		"medium":
			Global.highest_score_medium = Global.highest_score
			Global.second_highest_score_medium = Global.second_highest_score 
			Global.third_highest_score_medium = Global.third_highest_score
		"hard":
			Global.highest_score_hard = Global.highest_score
			Global.second_highest_score_hard = Global.second_highest_score 
			Global.third_highest_score_hard = Global.third_highest_score
	
	#setting up the end screen
	$VBoxContainer/QuitText.visible = true
	$VBoxContainer/QuitText.text = "Game Over\nYour Score " + str(Global.score)
	$VBoxContainer/PauseText.visible = false
	var string = $VBoxContainer/HighScores.text 
	var new_string = string % [Global.highest_score, Global.second_highest_score, Global.third_highest_score]
	$VBoxContainer/HighScores.text = new_string
	$VBoxContainer/HighScores.visible = true
	$Container/HighscoreBG.visible = true
	$VBoxContainer/RestartText.visible= true
	
	