extends Node2D

onready var structures = {
	"Pump": preload("res://objects/pump.tscn"),
	"Bomb": preload("res://objects/bomb.tscn"),
	"Cannon": preload("res://objects/cannon.tscn"),
}

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
	if not G.selected_structure:
		return false
	var structure = structures[G.selected_structure.name].instance()
	structure.global_position = position * C.CELL_SIZE + self.global_position
	$blocks.add_child(structure)
	print("Added at ", position, G.selected_structure.name)
