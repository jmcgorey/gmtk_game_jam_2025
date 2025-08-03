extends Node

@export var active_item_tracker: ActiveItemTracker
@export var item_definition_provider: ItemDefinitionProvider
@export var upgrade_definition_provider: UpgradeDefinitionProvider
@export var shop_item_tracker: ShopItemTracker
@export var score_manager: ScoreManager

@onready var shop_upgrade_tracker: ShopUpgradeTracker = %ShopUpgradeTracker
@onready var shop_items_viewer: VBoxContainer = %ShopItemsViewer
@onready var shop_upgrades_viewer: VBoxContainer = %ShopUpgradesViewer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop_items_viewer.set_item_tracker(shop_item_tracker, on_shop_item_purchase)
	shop_upgrades_viewer.set_upgrade_tracker(shop_upgrade_tracker, on_shop_upgrade_purchase)
	init_shop()


func init_shop():
	init_items()
	# init_upgrades()


func init_items():
	print('Initializing shop items...')
	var defs: Array[ItemDefinition] = item_definition_provider.get_all_definitions().values()
	defs.sort_custom(_sort_by_store_slot_asc)
		
	for def in defs:
		if def.available_at_start == true:
			var shop_item = ShopItemTracker.ShopItem.from_definition(def, 0)
			shop_item_tracker.add_item(shop_item)
	
	print('Loaded shop items')
	shop_item_tracker.debug_list()

func purchase_item(item_id: String) -> void:
	var item_definition = item_definition_provider.get_definition(item_id)
	if item_definition == null:
		return
	
	var shop_item = shop_item_tracker.get_item(item_id)
	var current_count = shop_item.count
	
	# Deduct from point total
	score_manager.decrement_package_count(shop_item.cost)
	
	# Create active item
	var active_item = ActiveItemTracker.ActiveItem.from_definition(item_definition, current_count + 1)
	active_item_tracker.add_item(active_item)
	
	# Update the shop item
	var new_shop_item = ShopItemTracker.ShopItem.from_definition(item_definition, current_count + 1)
	shop_item_tracker.add_item(new_shop_item)

func _sort_by_store_slot_asc(def1: ItemDefinition, def2: ItemDefinition) -> int:
	return def1.store_slot < def2.store_slot


func check_for_new_upgrades():
	# Create a shop upgrade for any upgrades that are ready to be put in the store
	for upgrade: BaseUpgrade in upgrade_definition_provider.get_all_definitions().values():
		if upgrade.is_purchased:
			continue
		if shop_upgrade_tracker.has(upgrade.id):
			continue
		if upgrade is ItemUpgrade:
			if active_item_tracker.has(upgrade.from_item_id):
				var shop_upgrade = ShopUpgradeTracker.ShopUpgrade.from_definition(upgrade)
				shop_upgrade_tracker.add_item(shop_upgrade)


func purchase_upgrade(upgrade_id: String):
	var def: BaseUpgrade = upgrade_definition_provider.get_definition(upgrade_id)
	
	if def is ItemUpgrade:
		# Replace the item with its upgrade
		var item_def = item_definition_provider.get_definition(def.to_item_id)
		var cur_shop_item = shop_item_tracker.get_item(def.from_item_id)
		
		# - Replace Active Item
		var active_item = ActiveItemTracker.ActiveItem.from_definition(item_def, cur_shop_item.count)
		active_item_tracker.replace_item(def.from_item_id, active_item)
		
		# - Replace Store Item
		var shop_item = ShopItemTracker.ShopItem.from_definition(item_def, cur_shop_item.count)
		shop_item_tracker.replace_item(def.from_item_id, shop_item)
	
	# Deduct from point total
	score_manager.decrement_package_count(def.cost)
	
	# Mark as purchased & remove the upgrade from the pool
	def.is_purchased = true
	shop_upgrade_tracker.remove_item(upgrade_id)

func on_shop_item_purchase(item_id: String):
	print('Purchasing item: ', item_id)
	purchase_item(item_id)
	check_for_new_upgrades()


func on_shop_upgrade_purchase(upgrade_id: String):
	print('Purchasing upgrade: ', upgrade_id)
	purchase_upgrade(upgrade_id)
	check_for_new_upgrades()
