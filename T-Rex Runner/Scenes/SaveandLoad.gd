extends Node

var highest_score
var second_highest_score
var third_highest_score
var music_volume_db
var sprite_colour
var background_colour
var difficulty

#complex_scoring
var highest_score_easy
var second_highest_score_easy 
var third_highest_score_easy 

var highest_score_medium
var second_highest_score_medium
var third_highest_score_medium

var highest_score_hard
var second_highest_score_hard
var third_highest_score_hard

var default_permanents  = {
		"highest_score_easy": 0,
		"second_highest_score_easy": 0,
		"third_highest_score_easy": 0,
		"highest_score_medium": 0,
		"second_highest_score_medium": 0,
		"third_highest_score_medium": 0,
		"highest_score_hard": 0,
		"second_highest_score_hard": 0,
		"third_highest_score_hard": 0,
		"music_volume_db": -30,
		"sprite_colour" : "#ffffff",
		"background_colour": "#000000",
		"difficulty": "easy",
	    }


func _ready():
	load_from_file()
	Global._load_permanents()
	print("no errors, woot!")


func save_information_as_dict():
	var save_dict = {
		"highest_score_easy": Global.highest_score_easy,
		"second_highest_score_easy": Global.second_highest_score_easy,
		"third_highest_score_easy": Global.third_highest_score_easy,
		"highest_score_medium": Global.highest_score_medium,
		"second_highest_score_medium": Global.second_highest_score_medium,
		"third_highest_score_medium": Global.third_highest_score_medium,
		"highest_score_hard": Global.highest_score_hard,
		"second_highest_score_hard": Global.second_highest_score_hard,
		"third_highest_score_hard": Global.third_highest_score_hard,
		"music_volume_db" : BGM.music_volume_db,
		"sprite_colour" : Global.sprite_colour,
		"background_colour": Global.background_colour,
		"difficulty" : Global.difficulty
	    }
	print("writing info")
	return save_dict


func save_to_file():
	var save_game = File.new()
	save_game.open_encrypted_with_pass("user://save_game.bin", File.WRITE, OS.get_unique_id())
	var node_data = self.call("save_information_as_dict")
	save_game.store_line(to_json(node_data))
	save_game.close()
	print(node_data)


func load_from_file():
	
	var save_game = File.new()
	if not save_game.file_exists("user://save_game.bin"):
		"no data found"
		reset_data()
		return
	save_game.open_encrypted_with_pass("user://save_game.bin", File.READ, OS.get_unique_id())
	var current_line = parse_json(save_game.get_line())
	var text = save_game.get_as_text()
	#print(save_game.get_as_text())
	for i in current_line.keys():
		self.set(str(i), current_line[i])
	print("loader node has been initialized")
	save_game.close()


func reset_data():
	print("default parameters will be used instead")
	var default_current_line = default_permanents
	for i in default_current_line.keys():
		self.set(str(i), default_current_line[i])
	Global._load_permanents()