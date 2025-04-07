extends Node2D

@export var sub: PackedScene
@export var sup : PackedScene
@export var sown : PackedScene
@export var bell : PackedScene

@onready var lanes = $lanes
@onready var depths = lanes.get_children()
@onready var bellpath = $bellpath

var current_target : Node2D

enum Enemy { SUB, SUP, SOWN, BELL, END}


var waves = []
var wave_start_time = 0
var current_time = 0
var current_wave

var event_list = []

var active_enemies = []

func add_event(enemy_type: int, timestamp: float, depth: int = -1) -> void:
	event_list.append({"enemy": enemy_type, "timestamp": timestamp, "depth": depth})

func add_wave(wave_events: Array) -> void:
	waves.append(wave_events)

func check_and_spawn_enemies(t: float) -> void:
	var events_to_remove = []
	for event in event_list:
		if event["timestamp"] <= t:
			spawn_enemy(event["enemy"], event["depth"])
			events_to_remove.append(event)

	for event in events_to_remove:
		event_list.erase(event)

func spawn_enemy(enemy_type: int, depth: int) -> void:
	if enemy_type == Enemy.END:
		start_wave(current_wave + 1)
	else:
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
			
		active_enemies.append(new_enemy)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_wave([
		{ "enemy": Enemy.SUB,	"timestamp": 2.0,	"depth": 3 },
		{ "enemy": Enemy.SUP,	"timestamp": 5.0,	"depth": 1 },
		{ "enemy": Enemy.SOWN,	"timestamp": 8.0,	"depth": 0 },
		{ "enemy": Enemy.BELL,	"timestamp": 10.0,	"depth": -1 },
		{ "enemy": Enemy.END,	"timestamp": 25.0,	"depth": -1 },
		
	])
	
	add_wave([		
		{ "enemy": Enemy.BELL,	"timestamp": 2.0, 	"depth": -1 },		
		{ "enemy": Enemy.SOWN, 	"timestamp": 5.0, 	"depth": 0 },		
		{ "enemy": Enemy.SUP, 	"timestamp": 8.0, 	"depth": 1 },
		{ "enemy": Enemy.SUB, 	"timestamp": 10.0, 	"depth": 2 },
		{ "enemy": Enemy.END,	"timestamp": 25.0,	"depth": -1 },
	])
	
	start_wave(0)

func start_wave(wave_index: int) -> void:
	active_enemies.clear()
	if wave_index < waves.size():
		current_wave = wave_index
		event_list.clear()
		event_list += waves[current_wave]
		wave_start_time = current_time
		print("Started Wave: " + str(current_wave + 1))

func restart_wave() -> void:
	if current_wave != -1:
		print("Restarting Wave: " + str(current_wave + 1))
		for enemy in active_enemies:
			if enemy:
				enemy.queue_free()
		start_wave(current_wave)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_time += delta
	check_and_spawn_enemies((current_time - wave_start_time))
	
func base_hit():
	restart_wave()

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
