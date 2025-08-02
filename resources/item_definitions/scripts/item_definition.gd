class_name ItemDefinition extends Resource

var base_background_texture = preload('res://assets/active-items/panel-template.png')
var base_shop_texture = preload('res://assets/shop-items/shop_placeholder.png')

## The internal ID for the item
@export var id: String

## The name to use to display this item to the user
@export var display_name: String

## The number of packages this item produces per second
@export var items_per_second: int

## The slot the item should occupy in the store
@export var store_slot: int

## The cost of purchasing the item for the first time
@export var base_cost: int

## The score to reach before the item becomes purchaseable in the shop
@export var reveal_cost: int

## <potential> How much more each purchase costs
@export var cost_scaler: float

## Whether the item should appear in the shop at the start of the round
@export var available_at_start: bool

## The texture to display for the item in the shop
@export var shop_texture: Texture2D

## A list of textures to display for the item in the active items list.
## Defaults to just listing the first one unless custom `get_background_image`
## logic is provided
@export var active_item_backgrounds: Array[Texture2D]

## Returns the cost of the item after n purchases
func get_cost(num_purchased: int) -> int:
	return int(base_cost + ((base_cost * cost_scaler) * num_purchased))

## Returns the icon texture for the shop item card
func get_shop_texture() -> Texture2D:
	if shop_texture == null:
		return base_shop_texture
	return shop_texture

## Returns the desired background image for the active item card 
func get_background_image(_num_purchased = 0) -> Texture2D:
	if active_item_backgrounds != null && !active_item_backgrounds.is_empty():
		return active_item_backgrounds[0]
	
	return base_background_texture


func debug() -> String:
	return display_name + '[' + id + ']'
