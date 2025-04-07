extends Area2D

@export var spawner : Node2D
@export var defeat_effect : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resupply_body_entered(body):
	if body is Player:
		if body.resupply(1):
			%PickUP.play()



func _on_area_entered(area):
	area.get_parent().queue_free()
	spawner.base_hit()
	var defeat = defeat_effect.instantiate()
	add_child(defeat)


func _on_resupply_body_exited(body):
	if body is Player:
		body.leave_dock()
