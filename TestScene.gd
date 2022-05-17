extends Spatial

func _process(_delta):
	$Camera.look_at($Plane03.transform.origin, Vector3.UP)
