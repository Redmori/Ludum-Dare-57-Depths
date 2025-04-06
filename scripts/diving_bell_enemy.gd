extends PathFollow2D

var speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += speed * delta


func _on_area_2d_area_entered(area):
	queue_free()
