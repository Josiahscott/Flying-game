extends Camera

export var lerp_speed = 0.35
onready var target = get_parent().get_node("Plane")
onready var camera_pos = get_tree().get_nodes_in_group("CameraPos")[0]
#
#export (NodePath) var target_path = null
#export (Vector3) var offset = Vector3.ZERO


func _process(delta):
	$Arrow.look_at(get_node("/root/World/Objective").global_transform.origin,Vector3.UP)
	global_transform.origin = camera_pos.global_transform.origin
	rotation = rotation(camera_pos.rotation,lerp_speed)

#func _ready():
#	if target_path:
#		target = get_node(target_path)
#
#func _physics_process(delta):
#	if !target:
#		return
#	var target_pos = target.global_transform.translated(offset)
#	global_transform.origin = global_transform.origin.move_toward(target_pos, lerp_speed)
#	global_transform = global_transform.interpolate_with(target_pos, lerp_speed * delta)
#	look_at(target.global_transform.origin, target.transform.basis.y)
