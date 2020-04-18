extends Node2D


func _on_Panel_mouse_entered() -> void:
	#print("panel entered")
	$Sprite.animation = "press"


func _on_Panel_mouse_exited() -> void:
	#print("panel exited")
	$Sprite.animation = "default"


func _on_Panel_gui_input(event: InputEvent) -> void:
	if event.is_action("ui_mouse") == true:
		get_tree().change_scene("res://Scenes/Intro Menu.tscn")
		Global.timer = 0
		Global.score = 0
		Engine.time_scale = 0
		Global.is_restart = false