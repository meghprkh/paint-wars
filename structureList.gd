extends ItemList

onready var item_list_node = get_node(".")
onready var structures = [
	Structure.new(C.Structures.PUMP, 2000, 1, preload("res://assets/sprites/pump.png")),
	Structure.new(C.Structures.CANNON, 100, 1, preload("res://assets/sprites/cannon.png")),
	Structure.new(C.Structures.BOMB, 500, 1, preload("res://assets/sprites/bomb.png")),
]


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


func _on_structureList_item_selected(index):
	var structure = structures[index]
	G.selected_structure = structure
