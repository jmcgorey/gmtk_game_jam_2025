extends Node

@export var card_scene: PackedScene
var shop_item_tracker: ShopItemTracker


func set_item_tracker(_shop_item_tracker: ShopItemTracker):
	shop_item_tracker = _shop_item_tracker
	shop_item_tracker.items_changed.connect(on_shop_items_changed)
	update_view()


func update_view():
	clear_cards()
	
	# Create cards for each item
	var items = shop_item_tracker.get_all_items()
	for item in items:
		create_card(item)


func clear_cards():
	var children = get_children()
	for child in children:
		if is_instance_valid(child):
			child.queue_free()


func create_card(item: ShopItemTracker.ShopItem):
	var card_instance: ShopItemCard = card_scene.instantiate()
	add_child(card_instance)
	card_instance.set_properties(item)


func on_shop_items_changed():
	update_view()
