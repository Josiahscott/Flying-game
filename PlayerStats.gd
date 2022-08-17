extends Node

var fuel
var fuel_max
var speed
var points
var points_max
var flaps
var flaps_max
var alt

func _ready():
	fuel = 100
	fuel_max = 100
	alt = 0
	speed = 0
	points = 0
	points_max = 100
	flaps = 0
	flaps_max = 100
	
func get_flaps():
	return flaps
	
func change_flaps(amount):
	flaps = amount
	flaps = clamp(flaps,0, flaps_max)
func change_fuel(amount):
	fuel += amount
	fuel = clamp(fuel,0, fuel_max)

func get_fuel():
	return fuel

func change_alt(amount):
	alt = amount

func get_alt():
	return alt

func change_speed(amount):
	speed = amount
	
func get_speed():
	return speed

func change_points(amount):
	points = amount
	points = clamp(points,0, points_max)

func get_points():
	return points

func _physics_process(delta):
	if points == 100:
		get_tree().change_scene("res://game end or win/Game win.tscn")
	if fuel == 0:
		get_tree().change_scene("res://game end or win/Game End.tscn")

