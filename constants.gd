extends Node

const WIDTH = 1024
const HEIGHT = 576

const CELL_SIZE = 32
const GRID_COLS = 28  # 4 cols remaining to the right
const GRID_ROWS = 18

const SPEED = 5

enum Player {
	P1,
	P2
}

const PlayerColors = {
	Player.P1: Color(0.15, 0.95, 0.15),
	Player.P2: Color(0.15, 0, 0.95),
}
