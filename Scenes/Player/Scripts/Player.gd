extends CharacterBody2D

# So we can adjust things as needed
@onready var Cam = %Camera
@onready var CamPos = %CameraPos
@onready var Sprite = %Sprite

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCEL = 0.05
const FRIC = 0.2

var MovingX = false
var MovingY = false
var Moving = false

var CanMove = true

func handle_movement(_d): # Self explanatory
	if not CanMove: # For cutscenes and whatnot
		velocity = Vector2.ZERO
		return
	
	if Input.is_action_pressed("W"): # Going through each direction and setting movement, not optimal but I like it this way lmao
		velocity.y = lerp(velocity.y, -SPEED, ACCEL)
		MovingY = true
	elif Input.is_action_pressed("S"):
		velocity.y = lerp(velocity.y, SPEED, ACCEL)
		MovingY = true
	else:
		velocity.y = lerp(velocity.y, 0.0, FRIC)
		MovingY = false
	if Input.is_action_pressed("A"):
		velocity.x = lerp(velocity.x, -SPEED, ACCEL)
		MovingX = true
	elif Input.is_action_pressed("D"):
		velocity.x = lerp(velocity.x, SPEED, ACCEL)
		MovingX = true
	else:
		velocity.x = lerp(velocity.x, 0.0, FRIC)
		MovingX = false
	
	if MovingX or MovingY: # Probably not the best way to do this but hey
		Moving = true # Just for general use
	else:
		Moving = false

func handle_camera_movement():
	if Input.is_action_pressed("W"): # Doing the same as above but for the camera
		CamPos.position.y = lerp(CamPos.position.y, -SPEED / 8, ACCEL / 4)
	elif Input.is_action_pressed("S"):
		CamPos.position.y = lerp(CamPos.position.y, SPEED / 8, ACCEL / 4)
	else:
		CamPos.position.y = lerp(CamPos.position.y, 0.0, FRIC / 3)
	if Input.is_action_pressed("A"):
		CamPos.position.x = lerp(CamPos.position.x, -SPEED / 8, ACCEL / 4)
	elif Input.is_action_pressed("D"):
		CamPos.position.x = lerp(CamPos.position.x, SPEED / 8, ACCEL / 4)
	else:
		CamPos.position.x = lerp(CamPos.position.x, 0.0, FRIC / 3)

func _physics_process(delta: float) -> void:
	
	handle_camera_movement() # Just organising functions a little
	
	handle_movement(delta)

	move_and_slide()
