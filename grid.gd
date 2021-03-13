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
	if not G.selected_structure:
		return false
	var clicked_at = (event.position - self.global_position) / C.CELL_SIZE
	clicked_at = clicked_at.floor()
	if clicked_at.x > C.GRID_COLS or clicked_at.y > C.GRID_ROWS:
		return
	var player = C.Player.P1
	if Input.is_action_pressed("player2_modifier"):
		player = C.Player.P2
	add_structure(player, G.selected_structure.name, clicked_at)


func add_structure(player, structure_name, position):
	var structure = structures[structure_name].instance()
	structure.set_player(player)
	structure.global_position = position * C.CELL_SIZE + self.global_position
	$blocks.add_child(structure)
	print("Added ", structure_name, " for ", C.Player.keys()[player], " at ", position)
