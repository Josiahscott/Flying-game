extends Node

var fuel
var fuel_max
var speed
var points
var points_max

var alt
func _ready():
	fuel = 100
	fuel_max = 100
	alt = 0
	speed = 0
	points = 0
	points_max = 100

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
