extends PathFollow2D

var speed


var hit_timer_value = 1
var just_hit = false

func _ready():
	set_speed()

# Called when the node enters the scene tree for the first time.
func set_speed():
	speed = find_child("type").get_speed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += delta*speed
	
	if just_hit:
		hit_timer_value -= delta
		if hit_timer_value <= 0:
			just_hit = false
			hit_timer_value = 1



func _on_area_2d_area_entered(area):
	if !just_hit:
		just_hit = true
		var found_child
		for child in get_children():
			if child.name.begins_with("type"):
				found_child = child
		found_child.hit_effect()
		
