extends CanvasItem

onready var blocks_node = get_node("../blocks")
onready var paint_canvas_node = get_node(".")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


func _process(_delta):
	update()


func _draw():
	var cell_size = Vector2(C.CELL_SIZE, C.CELL_SIZE)
	for col_idx in range(C.GRID_COLS):
		for row_idx in range(C.GRID_ROWS):
			var cell_position = Vector2(col_idx * C.CELL_SIZE, row_idx * C.CELL_SIZE)
			var cell_state = blocks_node.coverage_map[col_idx][row_idx]
			var cell_color = C.PlayerColors[C.Player.P1]
			if cell_state > 0:
				cell_color = C.PlayerColors[C.Player.P2]
			cell_color.a = abs(cell_state)
			paint_canvas_node.draw_rect(Rect2(cell_position, cell_size), cell_color)
