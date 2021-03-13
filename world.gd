extends Node2D

var pump_speed_x = C.SPEED
var pump_speed_y = C.SPEED


func _physics_process(_delta):
	if $pump.global_position.x > C.WIDTH or $pump.global_position.x < 0:
		pump_speed_x *= -1
	if $pump.global_position.y > C.HEIGHT or $pump.global_position.y < 0:
		pump_speed_y *= -1
	$pump.global_position.x += pump_speed_x
	$pump.global_position.y += pump_speed_y
