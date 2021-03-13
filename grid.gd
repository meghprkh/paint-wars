extends Node2D

onready var pump_scene = preload("res://objects/pump.tscn")

func _input(event):
	# Mouse in viewport coordinates.
	if not event is InputEventMouseButton or not event.is_pressed():
		return
	var clicked_at = (event.position - self.global_position) / C.CELL_SIZE
	clicked_at = clicked_at.floor()
	if clicked_at.x > C.GRID_COLS or clicked_at.y > C.GRID_ROWS:
		return
	add_pump(clicked_at)
	
func add_pump(position):
	var pump = pump_scene.instance()
	pump.global_position = position * C.CELL_SIZE + self.global_position
	$blocks.add_child(pump)
	print("Added pump at ", position)
