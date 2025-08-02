class_name ActiveItemTracker extends BaseItemTracker


class ActiveItem extends BaseItemTracker.BaseItem:
	## The number of these items that exist
	var count: int
	## The amount of packages these items each produce per second
	var items_per_second: int
	## The texture to use to display the item
	var texture: Texture2D
	
	# Creates an ActiveItem based on the given ItemDefinition
	static func from_definition(definition: ItemDefinition, _count: int) -> ActiveItem:
		var item = ActiveItem.new()
		
		item.id = definition.id
		item.display_name = definition.display_name
		item.count = _count
		item.items_per_second = definition.items_per_second
		item.texture = definition.get_background_image(_count)
		
		return item
	
	func debug() -> String:
		return display_name + '[' + id + ']: ' + 'count=' + str(count) + ', base_ips=' + str(items_per_second) + ', total_ips=' + str(items_per_second * count)


## Returns the item specified by `item_id`.  Returns `null` if the
## desired item is not present in the cache
func get_item(item_id: String) -> ActiveItem:
	return super(item_id) as ActiveItem


## Returns the list of all items in the cache
func get_all_items() -> Array[ActiveItem]:
	# Convert type to ActiveItem to make Godot happy
	var items: Array[ActiveItem] = []
	for item: ActiveItem in super():
		items.push_back(item)
	
	return items
