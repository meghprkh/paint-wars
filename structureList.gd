extends ItemList

onready var item_list_node = get_node(".")


class Structure:
	var name: String
	var cost: int
	var tier: int
	var img: String

	func _init(name, cost, tier, img):
		self.name = name
		self.cost = cost
		self.tier = tier
		self.img = img


# Called when the node enters the scene tree for the first time.
func _ready():
	var structures = [
		Structure.new("Pump", 2000, 1, "res://assets/sprites/pump.png"),
		Structure.new("Cannon", 100, 1, "res://assets/sprites/cannon.png"),
		Structure.new("Bomb", 500, 1, "res://assets/sprites/bomb.png")
	]
	var icon_target_size = Vector2(64, 64)
	for structure in structures:
		var item_label = "%s (%d)" % [structure.name, structure.cost]

		var texture = ImageTexture.new()
		var image = Image.new()
		image.load(structure.img)
		texture.create_from_image(image)
		texture.set_size_override(icon_target_size)

		item_list_node.add_item(item_label, texture, true)
