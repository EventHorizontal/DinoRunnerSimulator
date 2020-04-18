extends KinematicBody2D


export var jump_speed = 300
export var long_jump_speed = 500
export var _gravity = 500

var linear_velocity = Vector2.ZERO

onready var cactus_detector =  get_child(3)

signal cactus_detected


func _physics_process(delta: float) -> void:
	if $Sprite/AnimationPlayer.current_animation != "death":
		#movement
		
		#gravity
		linear_velocity.y += _gravity * delta
		
		#killswitch for debugging
		if OS.is_debug_build():
			if Input.is_action_just_pressed("killswitch"):
				$Sprite/AnimationPlayer.play("death")
				yield($Sprite/AnimationPlayer, "animation_finished")
				queue_free()
		
		#jump
		if is_on_floor():
			$Sprite/AnimationPlayer.play("run")
			if Input.is_action_just_pressed("jump"):
				linear_velocity.y = -jump_speed
			elif Input.is_action_pressed("long_jump"):
				linear_velocity.y = -long_jump_speed
		else:
			$Sprite/AnimationPlayer.play("jump")
		
		#final movement
		linear_velocity = move_and_slide(linear_velocity, Vector2.UP)
		
	#cactus_detector
	cactus_detect()
	"cactus detector mechanism engage!"

func cactus_detect() -> void:
	if cactus_detector.is_colliding() && "Cactus" in cactus_detector.get_collider().name:
		cactus_detector.enabled = false 
		print("cactus detected")
		emit_signal("cactus_detected")
		if $Timer.is_stopped():
			$Timer.start(.5)


func _on_Timer_timeout() -> void:
	cactus_detector.enabled = true
	print("detector enabled")


func _on_Area2D_area_entered(area: Area2D) -> void:
	$Sprite/AnimationPlayer.play("death")
	yield($Sprite/AnimationPlayer, "animation_finished")
	queue_free()