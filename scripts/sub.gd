extends Node2D

var speed = 30

var vspeed = 50
var target_offset
var move_to_y = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move_to_y:
		var direction = sign(target_offset - get_parent().v_offset)
		get_parent().v_offset += direction * delta * vspeed
		
		if abs(target_offset - get_parent().v_offset) < 1:
			get_parent().v_offset = target_offset
			move_to_y = false

func get_speed():
	return speed

func hit_effect():
	get_parent().queue_free()
	
