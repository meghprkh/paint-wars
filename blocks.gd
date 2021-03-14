extends Node2D

onready var tilemap_node = get_node("../map")
onready var tileset_node = tilemap_node.tile_set
onready var blocks_node = get_node(".")
# Records accumulated paint control per cell
onready var coverage_map = create_value_matrix(C.GRID_COLS, C.GRID_ROWS)


func create_value_matrix(w, h):
	var matrix = []
	for i in range(w):
		matrix.append([])
		matrix[i] = []
		for j in range(h):
			matrix[i].append([])
			matrix[i][j] = float(0)
	return matrix


func _ready():
	pass  # Replace with function body.


func hit(x, y, val):
	if 0 <= x and x < C.GRID_COLS and 0 <= y and y < C.GRID_ROWS:
		var next_val = min(1.0, max(-1.0, coverage_map[x][y] + val))
		coverage_map[x][y] = next_val

	#var tile_id = tilemap_node.get_cell(x, y)
	#tileset_node.remove_tile(tile_id)
	#tileset_node.create_tile(tile_id)
	#tileset_node.tile_set_material(tile_id, "") # test
	#tileset_node.tile_set_modulate (tile_id, Color(0, 0, 0))
	#tilemap_node.set_cell(x, y, tile_id)


func _physics_process(delta):
	var capture_rate = 10  # seconds until full - replace with structure speed
	for child in blocks_node.get_children():
		# For each structure, read in its effects and strengths and apply to board
		var tile_x = child.get_grid_x()
		var tile_y = child.get_grid_y()
		var paint_strength = delta / capture_rate
		if child.get_player() == C.Player.P2:
			paint_strength *= -1
		hit(tile_x, tile_y, paint_strength)
