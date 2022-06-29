extends Control

#sets the stat bars to max
func _ready():
	$Fuel/FuelBar.max_value = PlayerStats.fuel_max
	$Points/PointsBar.max_value = PlayerStats.points_max
func _process(delta):
	$Fuel/FuelBar.value = PlayerStats.get_fuel()
	$Alt/Alt.value = PlayerStats.get_alt()*10
	$Alt/Alt_Number.text = str(round(PlayerStats.alt*100))
	$Speed/Speed.value = PlayerStats.get_speed()
	$Speed/Speed_Number.text = str(round(PlayerStats.speed))
	$Points/PointsBar.value = PlayerStats.get_points()*10
	#Flaps
	#RPM
	#Vertical Speed

