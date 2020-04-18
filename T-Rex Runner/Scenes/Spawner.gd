extends Node

class_name EnemySpawner

export var min_time = 2 
export var max_time = 5 
export var first_time = 2.0

onready var spawnpoint = $Spawnpoint

var spawn_timer = Timer.new()
var random_time = 3
var EnemyResource


func _ready():
	#randomize seed based ion time
	randomize()
	
	#start spawn timers
	
	# spawn timer
	spawn_timer.connect("timeout", self, "_spawn")
	add_child(spawn_timer)
	spawn_timer.one_shot = true
	spawn_timer.wait_time = first_time
	spawn_timer.start()


func _spawn() -> void:
	var instance = EnemyResource.instance()
	instance.position = spawnpoint.global_position
	self.add_child(instance, true)
	_time_spawn(max_time, min_time)


func _time_spawn(max_time: float,min_time: float) -> void:
	var time_range = max_time - min_time
	random_time = clamp(randf()*time_range + min_time, min_time, max_time)
	#print(self.name, " ", random_time)
	spawn_timer.wait_time = random_time
	spawn_timer.start()