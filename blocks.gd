extends Node2D

onready var tilemap_node = get_node("../map")
onready var tileset_node = tilemap_node.tile_set
onready var blocks_node = get_node(".")
# Records accumulated paint control per cell
onready var coverage_map = create_value_matrix(C.GRID_COLS, C.GRID_ROWS)
onready var capture_rate = 10  # seconds until full - replace with structure speed
onready var spillover_rate = 0.5  # times the capture rate
onready var capture_threshold = 0.8  # percentage neede to claim tile
onready var pump_speed = 20  # credits per second


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


func process_spillover(delta):
	# All cardinal neighbours receive paint from neigbhoring capture tiles
	var spillover = (delta / capture_rate) * spillover_rate
	for col_idx in range(C.GRID_COLS):
		for row_idx in range(C.GRID_ROWS):
			var cell_val = coverage_map[col_idx][row_idx]
			var neighbour_list = [Vector2(0, 1), Vector2(1, 0), Vector2(0, -1), Vector2(-1, 0)]
			if abs(cell_val) >= capture_threshold:
				for neighbor in neighbour_list:
					if cell_val > 0:
						hit(col_idx + neighbor.x, row_idx + neighbor.y, spillover)
					else:
						hit(col_idx + neighbor.x, row_idx + neighbor.y, -spillover)


func process_pump(delta, player):
	G.player_credits[player] += delta * pump_speed


func _physics_process(delta):
	process_spillover(delta)
	for child in blocks_node.get_children():
		# For each structure, read in its effects and strengths and apply to board
		var tile_x = child.get_grid_x()
		var tile_y = child.get_grid_y()
		var paint_strength = delta / capture_rate
		var cur_player = child.get_player()
		if cur_player == C.Player.P2:
			paint_strength *= -1
		var cur_structure = child.get_type()
		if cur_structure == C.StructureNames[C.Structures.PUMP]:
			process_pump(delta, cur_player)
		hit(tile_x, tile_y, paint_strength)
