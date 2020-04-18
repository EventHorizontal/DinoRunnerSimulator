extends Node

#variables to be reset on quit
var timer = 0
var is_restart = false
var score = 0

#scoring
var highest_score
var second_highest_score
var third_highest_score

#dfficulty_based_scoring
var highest_score_easy
var second_highest_score_easy
var third_highest_score_easy

var highest_score_medium
var second_highest_score_medium
var third_highest_score_medium

var highest_score_hard
var second_highest_score_hard
var third_highest_score_hard

#colour options
var sprite_colour
var background_colour

#difficulty enum
var difficulty

#load_array
var load_array = [
		"highest_score_easy",
		"second_highest_score_easy", 
		"third_highest_score_easy", 
		"highest_score_medium", 
		"second_highest_score_medium", 
		"third_highest_score_medium", 
		"highest_score_hard", 
		"second_highest_score_hard", 
		"third_highest_score_hard",
		"sprite_colour", 
		"background_colour", 
		"difficulty"
	]
	 


func _ready() -> void:
	var saveandload = Node.new()
	saveandload.name = "SaveandLoad"
	saveandload.set_script(load("res://Scenes/SaveandLoad.gd"))
	self.add_child(saveandload)
	match difficulty:
		"easy": 
			Global.highest_score = Global.highest_score_easy
			Global.second_highest_score = Global.second_highest_score_easy
			Global.third_highest_score = Global.third_highest_score_easy
		"medium":
			Global.highest_score = Global.highest_score_medium
			Global.second_highest_score = Global.second_highest_score_medium
			Global.third_highest_score = Global.third_highest_score_medium
		"hard":
			Global.highest_score = Global.highest_score_hard
			Global.second_highest_score = Global.second_highest_score_hard
			Global.third_highest_score = Global.third_highest_score_hard


func _process(delta: float) -> void:
	if get_tree().get_root().get_child(2).name == "Game":
		 timer += delta


func _notification(what: int) -> void:
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		save_and_quit()


func save_and_quit():
	get_child(0).save_to_file()
	get_tree().quit()


func _load_permanents()-> void:
	print("loading permanents to Global node")
	if get_child_count() > 0:
		var buffer
		for i in range(0, load_array.size()):
			Global.set(load_array[i], $SaveandLoad.get(load_array[i]))
			print("Global obtained ", load_array[i], ": ", Global.get(load_array[i]))
		print("Successfully loaded scores") 


