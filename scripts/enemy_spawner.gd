extends Node2D

@export var sub: PackedScene
@export var sup : PackedScene
@export var sown : PackedScene
@export var bell : PackedScene

@onready var lanes = $lanes
@onready var depths = lanes.get_children()
@onready var bellpath = $bellpath

var current_target : Node2D

enum Enemy { SUB, SUP, SOWN, BELL}

var event_list = []

func add_event(enemy_type: int, timestamp: float, depth: int = -1) -> void:
	event_list.append({"enemy": enemy_type, "timestamp": timestamp, "depth": depth})

func check_and_spawn_enemies(t: float) -> void:
	var events_to_remove = []
	for event in event_list:
		if event["timestamp"] <= t:
			spawn_enemy(event["enemy"], event["depth"])
			events_to_remove.append(event)  # Add event to remove list

	# Now remove the processed events
	for event in events_to_remove:
		event_list.erase(event)

func spawn_enemy(enemy_type: int, depth: int) -> void:
	var new_enemy
	
	match enemy_type:
		Enemy.SUB:
			print("Spawning SUB enemy with depth: ", depth)
			new_enemy = sub.instantiate()
		Enemy.SUP:
			print("Spawning SUP enemy with depth: ", depth)
			new_enemy = sup.instantiate()
		Enemy.SOWN:
			print("Spawning SOWN enemy with depth: ", depth)
			new_enemy = sown.instantiate()
		Enemy.BELL:
			print("Spawning BELL enemy")
			new_enemy = bell.instantiate()
			bellpath.add_child(new_enemy)
	
	if depth != -1:
		depths[depth].get_node("Path").add_child(new_enemy)

var wave_start_time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	add_event(Enemy.SUB, 	2.0,	3) 
	add_event(Enemy.SUP, 	5.0,	1) 
	add_event(Enemy.SOWN, 	8.0,	0) 
	add_event(Enemy.BELL, 	10.0	) 
	
	wave_start_time = 0

var current_time = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_time += delta
	check_and_spawn_enemies((current_time - wave_start_time))


func _on_timer_timeout():
	
	
	
	
	var random_type = randi_range(0, 3)
	var new_enemy
	
	#random_type = 2 #override
	
	if random_type == 0:
		new_enemy = sup.instantiate()
	elif random_type == 1:
		new_enemy = sown.instantiate()
	elif random_type == 2:
		new_enemy = bell.instantiate()
		bellpath.add_child(new_enemy)
	else:
		new_enemy = sub.instantiate()
	
	
	if new_enemy.get_parent() == null:
		var random_number = randi_range(0, depths.size()-1)
		
		#random_number = 0 #override
		
		depths[random_number].get_node("Path").add_child(new_enemy)
	
func set_target(target):
	if target is Depth:
		current_target = target

func get_target():
	return current_target
