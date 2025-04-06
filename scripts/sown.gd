extends Node2D

var speed = 25

@export var remnant : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_speed():
	return speed

func hit_effect():
	var new_remnant = remnant.instantiate()
	get_parent().add_child(new_remnant)
	new_remnant.name = "type"
	new_remnant.move_to_y = true
	new_remnant.target_offset = 32
	queue_free()
	
