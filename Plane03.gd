extends KinematicBody


onready var LEFT_AILERON = $Plane/Plane/Body/Parts/LEFT_AILERON
onready var RIGHT_AILERON = $Plane/Plane/Body/Parts/RIGHT_AILERON
onready var ELEVATOR = $Plane/Plane/Body/Parts/ELEVATOR
onready var RUDDER = $Plane/Plane/Body/Parts/RUDDER
var gravity = Vector3(0,9.8,0)

var min_take_off_speed = 10
# Can't fly below this speed
var min_flight_speed = 00
# Maximum airspeed
var max_flight_speed = 40
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

# Current speed
var forward_speed = 0
# Throttle input speed
var target_speed = 0
# Lets us change behavior when grounded
var grounded = false

var velocity = Vector3.ZERO
var turn_input = 0
var pitch_input = 0

var LEFT_UP_TARGET = Vector3(21.1, -1.9, 0)
var RIGHT_DOWN_TARGET = Vector3(-21.1, -4.5, 1.5)
var LEFT_DOWN_TARGET = Vector3(-21.1, 2.3, 0)
var RIGHT_UP_TARGET = Vector3(21.1, 3.5, 0)
var ELEVATOR_UP_TARGET = Vector3(20,0,0)
var ELEVATOR_DOWN_TARGET = Vector3(-20,0,0)
var RUDDER_LEFT_TARGET = Vector3(0,0,10)
var RUDDER_RIGHT_TARGET = Vector3(0,0,-10)

func _ready():
	DebugOverlay.stats.add_property(self, "grounded", "")
	DebugOverlay.stats.add_property(self, "forward_speed", "round")
	
func _physics_process(delta):
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
	#print(velocity)
#	print(velocity.y + velocity.x)
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
	if forward_speed >= min_take_off_speed:
		pitch_input += Input.get_action_strength("pitch_up")

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
	else:
		LEFT_AILERON.rotation_degrees = lerp(LEFT_AILERON.rotation_degrees, Vector3.ZERO, .1)
		RIGHT_AILERON.rotation_degrees = lerp(RIGHT_AILERON.rotation_degrees, Vector3.ZERO, .1)

	if Input.is_action_pressed("pitch_up"):
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, ELEVATOR_UP_TARGET, .1)
	else:
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, Vector3.ZERO, .1)
	if Input.is_action_pressed("pitch_down"):
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, ELEVATOR_DOWN_TARGET, .1)
	else:
		ELEVATOR.rotation_degrees = lerp(ELEVATOR.rotation_degrees, Vector3.ZERO, .1)





