extends Node2D


func _ready():
	pass  # Replace with function body.


func _input(event):
	# Mouse in viewport coordinates.
	if not event is InputEventMouseButton or not event.is_pressed():
		return
	var clicked_at = (event.position - self.global_position) / C.CELL_SIZE
	clicked_at = clicked_at.floor()
	if clicked_at.x > C.GRID_COLS or clicked_at.y > C.GRID_ROWS:
		return
	print(clicked_at)
