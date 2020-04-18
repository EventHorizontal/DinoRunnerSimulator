extends "res://Scenes/Enemy.gd"


func _ready() -> void:
	$Cactus.self_modulate =  Color(Global.sprite_colour)