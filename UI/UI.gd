extends Control

#sets the stat bars to max
func _ready():
	$Fuel/FuelBar.max_value = PlayerStats.fuel_max
	$Points/PointsBar.max_value = PlayerStats.points_max
	$Flaps/FlapsBar.max_value = PlayerStats.flaps_max
func _process(delta):
	$Fuel/FuelBar.value = PlayerStats.get_fuel()
	$Alt/Alt.value = (PlayerStats.get_alt()*10)
	$Alt/Alt_Number.text = str(round(PlayerStats.alt*100))
	$Speed/Speed.value = (PlayerStats.get_speed()*100)
	$Speed/Speed_Number.text = str(round(PlayerStats.speed*100))
	$Points/PointsBar.value = PlayerStats.get_points()*10
	$Flaps/FlapsBar.value = PlayerStats.get_flaps()*3.5

