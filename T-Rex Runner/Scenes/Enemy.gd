extends RigidBody2D

class_name Enemy

export var velocity = Vector2(-60, 0)

func _ready() -> void:
	self.linear_velocity = velocity


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	print("Enemy Destroyed")