extends Node2D

var SPEED = 50
var target

@export var explosion : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta*SPEED
	if global_position.y >= target.global_position.y:
		var new_explosion = explosion.instantiate()
		new_explosion.global_position.x = self.global_position.x
		new_explosion.global_position.y = target.global_position.y
		get_parent().add_child(new_explosion)
		queue_free()
