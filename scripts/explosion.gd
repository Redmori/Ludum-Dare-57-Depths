extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	%shockwave_right.queue_free()
	%shockwave_left.queue_free()
	%explosion_right.queue_free()
	%explosion_left.queue_free()

func _on_audio_stream_player_2d_finished():
	queue_free()
