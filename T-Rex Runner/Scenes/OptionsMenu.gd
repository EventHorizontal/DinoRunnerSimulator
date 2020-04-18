extends Control

func _ready():
	
	#set options according to global variables
	
	#music_volume_db
	$CenterContainer/VboxContainer/GridContainer/HSlider.value = BGM.music_volume_db
	
	#difficulty
	match Global.difficulty:
		"easy": 
			$CenterContainer/VboxContainer/GridContainer/HBoxContainer2/Easy.pressed = true
		"medium":
			$CenterContainer/VboxContainer/GridContainer/HBoxContainer2/Medium.pressed = true
		"hard":
			$CenterContainer/VboxContainer/GridContainer/HBoxContainer2/Hard.pressed = true


func _on_BackButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Intro Menu.tscn")


func _on_HSlider_value_changed(value: float) -> void:
	BGM.music_volume_db = value
	BGM.volume_db = BGM.music_volume_db
	#print(BGM.music_volume_db)
	var value_to_percent = round(((value + 60) * 100) / 60)
	$CenterContainer/VboxContainer/GridContainer/Music.text = "Music Volume :\n(" + str(value_to_percent) + " %)" 


func _on_Easy_button_down() -> void:
	Global.get_child(0).save_to_file()
	Global.difficulty = "easy"
	Global.highest_score = Global.highest_score_easy
	Global.second_highest_score = Global.second_highest_score_easy
	Global.third_highest_score = Global.third_highest_score_easy


func _on_Medium_button_down() -> void:
	Global.get_child(0).save_to_file()
	Global.difficulty = "medium"
	Global.highest_score = Global.highest_score_medium
	Global.second_highest_score = Global.second_highest_score_medium
	Global.third_highest_score = Global.third_highest_score_medium


func _on_Hard_button_down() -> void:
	Global.get_child(0).save_to_file()
	Global.difficulty = "hard"
	Global.highest_score = Global.highest_score_hard
	Global.second_highest_score = Global.second_highest_score_hard
	Global.third_highest_score = Global.third_highest_score_hard


func _on_LineEdit_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse"):
			$SpriteColourHandler/PopupPanel.visible = not $SpriteColourHandler/PopupPanel.visible


func _on_LineEdit2_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse"):
		$BackgroundColourHandler/PopupPanel.visible = not $BackgroundColourHandler/PopupPanel.visible


func _on_SpriteColourHandler_colour_changed() -> void:
	$CenterContainer/VboxContainer/GridContainer/GridContainer/LineEdit.color = Color(Global.sprite_colour)
	for i in get_tree().get_nodes_in_group("modulate2"):
		i.set("custom_colors/font_color", Color(Global.sprite_colour))
	for i in get_tree().get_nodes_in_group("hover2"):
		i.set("self_modulate", Color(Global.sprite_colour))
	var style = StyleBoxFlat.new()
	styleboxflat_update()


func _on_BackgroundColourHandler_colour_changed() -> void:
	$CenterContainer/VboxContainer/GridContainer/GridContainer/LineEdit2.color = Color(Global.background_colour).darkened(0.2)
	$BG.color = Color(Global.background_colour)
	styleboxflat_update()

func styleboxflat_update():
	var style = StyleBoxFlat.new()
	$SpriteColourHandler/PopupPanel.add_stylebox_override("panel", style)
	style.bg_color = Color(Global.background_colour)
	style.set_border_width_all(1)
	style.border_color = Color(Global.sprite_colour)
	$BackgroundColourHandler/PopupPanel.add_stylebox_override("panel", style)
	style.bg_color = Color(Global.background_colour)
	style.set_border_width_all(1)
	style.border_color = Color(Global.sprite_colour)