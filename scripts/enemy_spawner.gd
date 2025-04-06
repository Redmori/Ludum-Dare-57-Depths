extends Node2D

@export var sub: PackedScene
@export var sup : PackedScene
@export var sown : PackedScene

@onready var lanes = $lanes
@onready var depths = lanes.get_children()

var current_target : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	
	var random_type = randi_range(0, 2)
	var new_enemy
	if random_type == 0:
		new_enemy = sup.instantiate()
	elif random_type == 1:
		new_enemy = sown.instantiate()
	else:
		new_enemy = sub.instantiate()
	
	
	var random_number = randi_range(0, depths.size()-1)
	depths[random_number].get_node("Path").add_child(new_enemy)
	
func set_target(target):
	if target is Depth:
		current_target = target

func get_target():
	return current_target
