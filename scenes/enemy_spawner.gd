extends Node2D

@export var enemy: PackedScene

@onready var lanes = $lanes
@onready var depths = lanes.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var new_enemy = enemy.instantiate()
	
	var random_number = randi_range(0, depths.size()-1)
	depths[random_number].get_node("Path").add_child(new_enemy)
