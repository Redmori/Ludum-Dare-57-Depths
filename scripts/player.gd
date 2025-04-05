class_name Player extends CharacterBody2D


const SPEED = 80.0
const ACCELERATION = 100

var target_position = position.x
var ammo = 1
var max_ammo = 1
var in_dock = false

@export var charge : PackedScene

@export var depth : Node2D

func _physics_process(delta):

	var current_target

	if ammo > 0:
		current_target = target_position
	else:
		current_target = 0
		
		
	
	var direction = current_target - position.x
	
	if abs(direction) < 0.01: #deadzone
		velocity.x = 0
	elif (velocity.x * velocity.x) / ( 1.5 * ACCELERATION) >= abs(direction) and sign(direction) == sign(velocity.x):
		velocity.x += sign(direction) * -ACCELERATION * delta # deccelerate
	else:
		velocity.x += sign(direction) * ACCELERATION * delta # accelerate
		
	#velocity.x += sign(direction) * ACCELERATION * delta # accelerate
		
	if abs(velocity.x) > SPEED:
		velocity.x = SPEED * sign(velocity.x)
		
	#velocity.x = current_target -  position.x
	#if velocity.x >= 0:
		#%Sprite2D.flip_h = true
		#%claw.position.x = -abs(%claw.position.x)
	#else:
		#%Sprite2D.flip_h = false
		#%claw.position.x = abs(%claw.position.x)
		
	
	if velocity.x < -16:
		%Sprite2D.frame = 0
		%claw.position.x = 13
	elif velocity.x < -12:
		%Sprite2D.frame = 1
		%claw.position.x = 10
	elif velocity.x < -8:
		%Sprite2D.frame = 2
		%claw.position.x = 7
	elif velocity.x < -4:
		%Sprite2D.frame = 3
		%claw.position.x = 4
	elif velocity.x > 16:
		%Sprite2D.frame = 8
		%claw.position.x = -13
	elif velocity.x > 12:
		%Sprite2D.frame = 7
		%claw.position.x = -10
	elif velocity.x > 8:
		%Sprite2D.frame = 6
		%claw.position.x = -7
	elif velocity.x > 4:
		%Sprite2D.frame = 5
		%claw.position.x = -4
	else:
		%Sprite2D.frame = 4
		%claw.position.x = 0
		
	
		
		


	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		target_position = event.position.x
		
	if not in_dock and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and ammo > 0:
		%claw.visible = false
		var new_charge = charge.instantiate()
		get_tree().get_root().add_child(new_charge)
		new_charge.global_position = %claw.global_position
		ammo -= 1
		new_charge.target = depth.get_target()

func resupply(amount):
	in_dock = true
	ammo += amount
	ammo = min(ammo, max_ammo)
	%claw.visible = true

func leave_dock():
	in_dock = false
