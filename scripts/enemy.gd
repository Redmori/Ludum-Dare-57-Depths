extends PathFollow2D

var speed

func _ready():
	set_speed()

# Called when the node enters the scene tree for the first time.
func set_speed():
	speed = find_child("type").get_speed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += delta*speed



func _on_area_2d_area_entered(area):
	queue_free()
