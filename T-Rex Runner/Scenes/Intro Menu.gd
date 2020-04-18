extends Control

func _ready() -> void:
	get_tree().paused = false
	$ColorRect.color = Color(Global.background_colour)
	for i in get_tree().get_nodes_in_group("modulate1"):
		i.set("custom_colors/font_color", Color(Global.sprite_colour))
	for i in get_tree().get_nodes_in_group("hover"):
		i.set("self_modulate", Color(Global.sprite_colour))
	var style = StyleBoxFlat.new()
	$PopupPanel.add_stylebox_override("panel", style)
	style.bg_color = Color(Global.background_colour)
	style.set_border_width_all(1)
	style.border_color = Color(Global.sprite_colour)


func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Options_pressed() -> void:
	get_tree().change_scene("res://Scenes/OptionsMenu.tscn")


func _on_Quit_pressed() -> void:
	Global.save_and_quit()


func _on_Reset_pressed() -> void:
	$PopupPanel.visible = true


func _on_Yes_pressed() -> void:
	Global.get_child(0).reset_data()
	Global.get_child(0).save_to_file()
	$ColorRect.color = Color(Global.background_colour)
	for i in get_tree().get_nodes_in_group("modulate1"):
		i.set("custom_colors/font_color", Color(Global.sprite_colour))
	for i in get_tree().get_nodes_in_group("hover"):
		i.set("self_modulate", Color(Global.sprite_colour))
	BGM.music_volume_db = Global.get_child(0).music_volume_db
	BGM.volume_db = BGM.music_volume_db
	$PopupPanel.visible = false	


func _on_No_pressed() -> void:
	$PopupPanel.visible = false

