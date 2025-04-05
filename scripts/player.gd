class_name Player extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var target_position = position.x
var ammo = 1

@export var charge : PackedScene

@export var depth : Node2D

func _physics_process(delta):
	## Add the gravity.
	##if not is_on_floor():
		##velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	var current_target

	if ammo > 0:
		current_target = target_position
	else:
		current_target = 0
	
	velocity.x = current_target -  position.x
	#if velocity.x >= 0:
		#%Sprite2D.flip_h = true
		#%claw.position.x = -abs(%claw.position.x)
	#else:
		#%Sprite2D.flip_h = false
		#%claw.position.x = abs(%claw.position.x)
		
	
	if velocity.x < -14:
		%Sprite2D.frame = 0
	elif velocity.x < -10:
		%Sprite2D.frame = 1
	elif velocity.x < -6:
		%Sprite2D.frame = 2
	elif velocity.x < -2:
		%Sprite2D.frame = 3
	elif velocity.x > 14:
		%Sprite2D.frame = 8
	elif velocity.x > 10:
		%Sprite2D.frame = 7
	elif velocity.x > 6:
		%Sprite2D.frame = 6
	elif velocity.x > 2:
		%Sprite2D.frame = 5
	else:
		%Sprite2D.frame = 4
		
	
		
		


	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		target_position = event.position.x
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and ammo > 0:
		%claw.visible = false
		var new_charge = charge.instantiate()
		get_tree().get_root().add_child(new_charge)
		new_charge.global_position = %claw.global_position
		ammo -= 1
		new_charge.target = depth.get_target()

func resupply(amount):
	ammo += amount
	%claw.visible = true
