extends AudioStreamPlayer

var music_volume_db = -30

func _ready():
	music_volume_db = Global.get_child(0).music_volume_db 
	self.autoplay = true
	self.stream = preload("res://Assets/Yellow Forest.ogg")
	self.volume_db = self.music_volume_db
	self.playing = true
	self.pause_mode = Node.PAUSE_MODE_PROCESS
