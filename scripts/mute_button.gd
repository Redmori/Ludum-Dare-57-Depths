extends Area2D

var muted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if not muted:
			$Sprite2D.frame = 1
			muted = true
			var bus_idx = AudioServer.get_bus_index("Master")
			AudioServer.set_bus_mute(bus_idx, true)
		else:
			$Sprite2D.frame = 0
			muted = false
			var bus_idx = AudioServer.get_bus_index("Master")
			AudioServer.set_bus_mute(bus_idx, false)
