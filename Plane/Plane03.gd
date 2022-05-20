extends KinematicBody


onready var LEFT_AILERON = $Plane/Plane/Body/Parts/LEFT_AILERON
onready var RIGHT_AILERON = $Plane/Plane/Body/Parts/RIGHT_AILERON
onready var ELEVATOR = $Plane/Plane/Body/Parts/ELEVATOR
onready var RUDDER = $Plane/Plane/Body/Parts/RUDDER
onready var ROLL = $Plane/Plane/Body
onready var PROPELLOR = $Plane/Plane/Body/Parts/PROP
onready var FLAPS = $Plane/Plane/Body/Parts/FLAPS
var gravity = Vector3(0,rotation_degrees.x*3,0)

var min_take_off_speed = 20
# Can't fly below this speed
var min_flight_speed = 0
# Maximum airspeed
var max_flight_speed = 200
# Turn rate
var turn_speed = 1.5
# Climb/dive rate
var pitch_speed = 1.5
# Lerp speed returning wings to level
var level_speed = 3.0
# Throttle change speed
var throttle_delta = 30
# Acceleration/deceleration
var acceleration = 15
var Boost = 0
# Current speed
var forward_speed = 0
# Throttle input speed
var target_speed = 0
# Lets us change behavior when grounded
var grounded = false

var velocity = Vector3.ZERO
var turn_input = 0
var pitch_input = 0

var LEFT_UP_TARGET = Vector3(35,-4.3,-2.3)
var RIGHT_DOWN_TARGET = Vector3(-35, -4.8, 3)
var LEFT_DOWN_TARGET = Vector3(-35, 3.8, -1.7)
var RIGHT_UP_TARGET = Vector3(35, 3.2, -0.5)
var ELEVATOR_UP_TARGET = Vector3(40,0,0)
var ELEVATOR_DOWN_TARGET = Vector3(-40,0,0)
var RUDDER_LEFT_TARGET = Vector3(2.5,-10.5,-30)
var RUDDER_RIGHT_TARGET = Vector3(-2.5,10.5,30)
var ROLL_LEFT_TARGET = Vector3(0,40,0)
var ROLL_RIGHT_TARGET = Vector3(0,-40,0) 
var FLAPS_DOWN_TARGET = Vector3(-30,0,0) 

func _ready():
	DebugOverlay.stats.add_property(self, "grounded", "")
	DebugOverlay.stats.add_property(self, "forward_speed", "round")
	DebugOverlay.stats.add_property(self, "Boost", "round")
	
func _physics_process(delta):
	if Input.is_action_pressed("throttle_up"):
		Boost = + 1

	
	get_input(delta)
	# Rotate the transform based on the input values
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_speed * delta)
	# If on the ground, don't roll the body
	if grounded:
		$Mesh/Body.rotation.y = 0
	else:
		# Roll the body based on the turn input
		$Mesh/Body.rotation.y = lerp($Mesh/Body.rotation.y, turn_input, level_speed * delta)
	# Accelerate/decelerate
	forward_speed = lerp(forward_speed, target_speed, acceleration * delta)
	PROPELLOR.rotation_degrees.y += rad2deg(1.75*forward_speed * delta)
	# Movement is always forward
	velocity = -transform.basis.z * forward_speed
	# Handle landing/taking off
	if is_on_floor():
		if not grounded:
			rotation.x = 0
		velocity.y -= 1
		grounded = true
	else:
		grounded = false
	if forward_speed < gravity.y:
		var current_gravity = gravity - Vector3(0,forward_speed,0)
		velocity = velocity - current_gravity
	velocity = move_and_slide(velocity, Vector3.UP)
	
func get_input(delta):
	# Throttle input
	if Input.is_action_pressed("throttle_up"):
		target_speed = min(forward_speed + throttle_delta * delta, max_flight_speed)
	if Input.is_action_pressed("throttle_down"):
		var limit = 0 if grounded else min_flight_speed
		target_speed = max(forward_speed - throttle_delta * delta, limit)
	# Turn (roll/yaw) input
	turn_input = 0
	if forward_speed > 0.5:
		turn_input -= Input.get_action_strength("roll_right")
		turn_input += Input.get_action_strength("roll_left")
	# Pitch (climb/dive) input
	pitch_input = 0
	if not grounded:
		pitch_input -= Input.get_action_strength("pitch_down")
	if not grounded:
		pitch_input += Input.get_action_strength("pitch_up")
	if grounded:
		if forward_speed >= min_take_off_speed:
			pitch_input += Input.get_action_strength("pitch_up")
		elif forward_speed <= min_take_off_speed:
			pitch_input += 0


	if Input.is_action_pressed("roll_left"):
		if not grounded:
			ROLL.rotation_degrees = lerp(ROLL.rotation_degrees, ROLL_LEFT_TARGET, .1)
	else:
			ROLL.rotation_degrees = lerp(ROLL.rotation_degrees, Vector3.ZERO, .1)
	if Input.is_action_pressed("roll_right"):
		if not grounded:
			ROLL.rotation_degrees = lerp(ROLL.rotation_degrees, ROLL_RIGHT_TARGET, .1)
	else:
			ROLL.rotation_degrees = lerp(ROLL.rotation_degrees, Vector3.ZERO, .1)
			
	if Input.is_action_pressed("roll_left"):
		LEFT_AILERON.rotation_degrees = lerp(LEFT_AILERON.rotation_degrees, LEFT_UP_TARGET, .1)
		RIGHT_AILERON.rotation_degrees = lerp(RIGHT_AILERON.rotation_degrees, RIGHT_DOWN_TARGET, .1)
		RUDDER.rotation_degrees = lerp(RUDDER.rotation_degrees, RUDDER_LEFT_TARGET, .1)

	else:
		LEFT_AILERON.rotation_degrees = lerp(LEFT_AILERON.rotation_degrees, Vector3.ZERO, .1)
		RIGHT_AILERON.rotation_degrees = lerp(RIGHT_AILERON.rotation_degrees, Vector3.ZERO, .1)
		RUDDER.rotation_degrees = lerp(RUDDER.rotation_degrees, Vector3.ZERO, .1)

	if Input.is_action_pressed("roll_right"):
		LEFT_AILERON.rotation_degrees = lerp(LEFT_AILERON.rotation_degrees, LEFT_DOWN_TARGET, .1)
		RIGHT_AILERON.rotation_degrees = lerp(RIGHT_AILERON.rotation_degrees, RIGHT_UP_TARGET, .1)
		RUDDER.rotation_degrees = lerp(RUDDER.rotation_degrees, RUDDER_RIGHT_TARGET, .1)

	else:
		LEFT_AILERON.rotation_degrees = lerp(LEFT_AILERON.rotation_degrees, Vector3.ZERO, .1)
		RIGHT_AILERON.rotation_degrees = lerp(RIGHT_AILERON.rotation_degrees, Vector3.ZERO, .1)
		RUDDER.rotation_degrees = lerp(RUDDER.rotation_degrees, Vector3.ZERO, .1)


	if Input.is_action_pressed("pitch_up"):
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, ELEVATOR_UP_TARGET, .1)
	else:
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, Vector3.ZERO, .1)
	if Input.is_action_pressed("pitch_down"):
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, ELEVATOR_DOWN_TARGET, .1)
	else:
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, Vector3.ZERO, .1)
	if Input.is_action_pressed("flaps_down"):
		gravity = Vector3(0,9.8*2,0)
		FLAPS.rotation_degrees = lerp(FLAPS.rotation_degrees, FLAPS_DOWN_TARGET, .1)
	if Input.is_action_pressed("flaps_up"):
		gravity = Vector3(0,9.8*3,0)
		FLAPS.rotation_degrees = lerp(FLAPS.rotation_degrees, Vector3.ZERO, .1)
	else:
		gravity = Vector3(0,9.8*3,0)
	



