extends Node

var _player = C.Player.P1
var _grid_x = 0
var _grid_y = 0


func _ready():
	set_color()


func set_player(p):
	_player = p
	set_color()


func get_player():
	return _player


func set_grid_x(x):
	_grid_x = x


func set_grid_y(y):
	_grid_y = y


func get_grid_x():
	return _grid_x


func get_grid_y():
	return _grid_y


func set_color():
	if _player == C.Player.P1:
		$sprite.modulate = C.PlayerColors[_player]
	else:
		$sprite.modulate = C.PlayerColors[_player]
