class_name ActiveItemTracker extends Node


class ActiveItem extends Resource:
	## The id of the item, used for tracking purposes
	var id: String
	## The name to use to display the item
	var display_name: String
	## The number of these items that exist
	var count: int
	## The amount of packages these items each produce per second
	var items_per_second: int
	## The texture to use to display the item
	var texture: Texture2D
	
	func debug() -> String:
		return display_name + '[' + id + ']: ' + 'count= ' + str(count) + ', ips=' + str(items_per_second)

## First when an item is added to the list
signal item_added(item_id: String)
## Fired when an item is replaced in the list
signal item_replaced(old_item_id: String, new_item_id: String)
## Fired when any change occurs in the cache
signal items_changed()

## The list of stored items, in order
var _item_cache: Array[ActiveItem] = []

## Adds a new ActiveItem to the list. Replaces it in place if 
## the item already exists.  Caller is responsible for changing
## any needed data values
func add_item(item: ActiveItem):
	if item == null:
		return
	
	# If the item isn't in the cache yet, add it as-is
	if !has(item.id):
		_item_cache.push_back(item)
	
	# If the item is already in the cache, overwrite all of the fields on it
	else:
		var index = _get_index(item.id)
		_item_cache[index] = item
	
	item_added.emit(item.id)
	items_changed.emit()


## Replaces the target item with thew new item
## Caller is responsible for setting any needed data
## Will fail if new item is already in list
func replace_item(item_to_replace_id: String, new_item: ActiveItem):
	if item_to_replace_id == null || new_item == null:
		return
	
	if has(item_to_replace_id) && !has(new_item.id):
		var index = _get_index(item_to_replace_id)
		_item_cache[index] = new_item
		
		item_replaced.emit(item_to_replace_id, new_item.id)
		items_changed.emit()


## Returns whether the target item is in the cache
func has(item_id: String) -> bool:
	return _get_index(item_id) != -1
	

## Returns the item specified by `item_id`.  Returns `null` if the
## desired item is not present in the cache
func get_item(item_id: String) -> ActiveItem:
	var index = _get_index(item_id)
	if index == -1:
		return null
	
	return _item_cache[index]


## Returns the list of all items in the cache
func get_all_items() -> Array[ActiveItem]:
	return _item_cache.duplicate()


## [Private] Gets the index of the target item
func _get_index(item_id: String) -> int:
	return _item_cache.find_custom(_find_by_id.bind(item_id))


## [Private] Sorting method used to match item to its id 
func _find_by_id(item: ActiveItem, item_id: String) -> bool:
	return item != null && item.id == item_id
