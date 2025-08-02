class_name BaseUpgrade extends Resource

var default_shop_texture = preload('res://assets/shop-items/shop_placeholder.png')

# The tracking ID for the upgrade
@export var id: String

# The name to use to display the upgrade in the shop
@export var display_name: String

# How much the upgrades costs in the shop
@export var cost: int

# [Unused] How many packages the user needs to reveal the item in the shop
@export var reveal_cost: int

# States whether the item should be available in the shop
@export var is_available: bool = false

# States whether the item has been purchased
@export var is_purchased: bool = false

# The texture to display for the upgrade in the shop (max 64px x 64px)
@export var texture: Texture2D = default_shop_texture

func debug() -> String:
	return display_name + '[' + id + ']'
