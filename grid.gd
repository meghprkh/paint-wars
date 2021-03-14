extends Node2D

onready var structures = {
	C.Structures.PUMP: preload("res://objects/pump.tscn"),
	C.Structures.BOMB: preload("res://objects/bomb.tscn"),
	C.Structures.CANNON: preload("res://objects/cannon.tscn"),
}

# TODO: Move to global
onready var structure_costs = {
	C.Structures.PUMP: 2000, C.Structures.BOMB: 500, C.Structures.CANNON: 100
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
	add_structure(player, G.selected_structure.structure, clicked_at)


func add_structure(player, structure_id, position):
	var structure = structures[structure_id].instance()
	if G.player_credits[player] < structure_costs[structure_id]:
		print(C.Player.keys()[player], " has insufficient credits")
		return
	G.player_credits[player] -= structure_costs[structure_id]
	structure.set_player(player)
	structure.set_grid_x(position.x)
	structure.set_grid_y(position.y)
	structure.set_type(C.StructureNames[structure_id])
	structure.global_position = position * C.CELL_SIZE + self.global_position
	$blocks.add_child(structure)
	print(
		"Added ", C.StructureNames[structure_id], " for ", C.Player.keys()[player], " at ", position
	)
