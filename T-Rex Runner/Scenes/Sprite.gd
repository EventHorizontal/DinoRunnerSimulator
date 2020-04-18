extends Node2D


func _on_Panel_mouse_entered() -> void:
	$Sprite.animation = "press"


func _on_Panel_mouse_exited() -> void:
	$Sprite.animation = "default"
