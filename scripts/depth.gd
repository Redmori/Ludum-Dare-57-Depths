class_name Depth extends Node2D

@onready var sprite_2d = $Sprite2D


func _on_area_2d_mouse_entered():
	get_parent().get_parent().set_target(self)
