extends "res://Scenes/Enemy.gd"


func _ready() -> void:
	$Sprite.self_modulate =  Color(Global.sprite_colour)