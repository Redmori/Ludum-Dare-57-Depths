class_name Depth extends Node2D



func _on_area_2d_mouse_entered():
	get_parent().get_parent().set_target(self)
