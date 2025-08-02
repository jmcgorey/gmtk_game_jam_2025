extends Node

@export var card_scene: PackedScene
var shop_upgrade_tracker: ShopUpgradeTracker
var shop_card_click_handler: Callable


func set_upgrade_tracker(_shop_item_tracker: ShopUpgradeTracker, card_click_handler: Callable):
	shop_upgrade_tracker = _shop_item_tracker
	shop_upgrade_tracker.items_changed.connect(on_shop_upgrades_changed)
	shop_card_click_handler = card_click_handler
	update_view()


func update_view():
	clear_cards()
	
	# Create cards for each item
	var upgrades = shop_upgrade_tracker.get_all_items()
	for upgrade in upgrades:
		create_card(upgrade)


func clear_cards():
	var children = get_children()
	for child in children:
		if is_instance_valid(child):
			child.queue_free()


func create_card(upgrade: ShopUpgradeTracker.ShopUpgrade):
	var card_instance: ShopUpgradeCard = card_scene.instantiate()
	add_child(card_instance)
	card_instance.set_properties(upgrade)
	card_instance.upgrade_button_pressed.connect(shop_card_click_handler)


func on_shop_upgrades_changed():
	update_view()
