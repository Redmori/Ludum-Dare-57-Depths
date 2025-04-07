extends Node2D

var i = 0

@onready var explosions_set = $explosions
@onready var explosions = explosions_set.get_children()
@onready var sound = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	explosions[i].play()
	sound.play()
	i += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if i > 10:
		queue_free()
	elif i >5 :
		i += 1
	else:
		explosions[i].play()
		sound.play()
		i += 1
