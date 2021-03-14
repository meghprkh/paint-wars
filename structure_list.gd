extends ItemList

onready var item_list_node = get_node(".")
onready var structures = [
	Structure.new(C.Structures.PUMP, 2000, 1, preload("res://assets/sprites/pump.png")),
	Structure.new(C.Structures.CANNON, 100, 1, preload("res://assets/sprites/cannon.png")),
	Structure.new(C.Structures.BOMB, 500, 1, preload("res://assets/sprites/bomb.png")),
]
onready var structure_costs = make_cost_map(structures)


func make_cost_map(structure_list):
	var structure_cost_map = {}
	for structure in structure_list:
		structure_cost_map[structure.name] = structure.cost
	return structure_cost_map


class Structure:
	var structure: int
	var name: String
	var cost: int
	var tier: int
	var texture: StreamTexture

	func _init(_structure, _cost, _tier, _texture):
		self.structure = _structure
		self.name = C.StructureNames[self.structure]
		self.cost = _cost
		self.tier = _tier
		self.texture = _texture


# Called when the node enters the scene tree for the first time.
func _ready():
	# Resizing asset at runtime is not recommended and gave a debugger warning
	# hence commented out
	# Using FixedIconSize in ItemList to get this to work
	# var icon_target_size = Vector2(64, 64)
	for structure in structures:
		var item_label = "%s (%d)" % [structure.name, structure.cost]
		item_list_node.add_item(item_label, structure.texture, true)


func _process(_delta):
	for i in range(item_list_node.get_item_count()):
		# check both players for demo
		var cur_structure = structures[i]
		if (
			G.player_credits[C.Player.P1] >= cur_structure.cost
			or G.player_credits[C.Player.P2] >= cur_structure.cost
		):
			item_list_node.set_item_disabled(i, false)
		else:
			item_list_node.set_item_disabled(i, true)


func _on_structure_list_item_selected(index):
	var structure = structures[index]
	G.selected_structure = structure
