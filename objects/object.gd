extends Node

var _player = C.Player.P1


func _ready():
	set_color()


func set_player(p):
	_player = p
	set_color()


func set_color():
	if _player == C.Player.P1:
		$sprite.modulate = C.PlayerColors[_player]
	else:
		$sprite.modulate = C.PlayerColors[_player]
