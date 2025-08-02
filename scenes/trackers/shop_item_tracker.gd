class_name ShopItemTracker extends BaseItemTracker


class ShopItem extends BaseItemTracker.BaseItem:
	## The number of these items that exist
	var count: int
	## How much it costs to purchase the next item in this category 
	var cost: int
	## The texture to use to display the item in the shop
	var texture: Texture2D
	
	## Creates a ShopItem from an ItemDefinition
	static func from_definition(definition: ItemDefinition, _count: int) -> ShopItem:
		var item = ShopItem.new()
		item.id = definition.id
		item.display_name = definition.display_name
		item.texture = definition.shop_texture
		item.count = _count
		item.cost = definition.get_cost(_count)
		
		return item
	
	func debug() -> String:
		return display_name + '[' + id + ']: ' + 'count=' + str(count) + ', cost=' + str(cost)

## Returns the item specified by `item_id`.  Returns `null` if the
## desired item is not present in the cache
func get_item(item_id: String) -> ShopItem:
	return super(item_id) as ShopItem


## Returns the list of all items in the cache
func get_all_items() -> Array[ShopItem]:
	# Convert type to ShopItem to make Godot happy
	var items: Array[ShopItem] = []
	for item: ShopItem in super():
		items.push_back(item)
	
	return items
