extends Node

@export var active_item_tracker: ActiveItemTracker
@export var item_definition_provider: ItemDefinitionProvider
@export var shop_item_tracker: ShopItemTracker
@export var score_manager: ScoreManager

@onready var shop_items_viewer: VBoxContainer = $ShopItemsViewer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop_items_viewer.set_item_tracker(shop_item_tracker, on_shop_item_purchase)
	init_shop()


func init_shop():
	init_items()

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


func on_shop_item_purchase(item_id: String):
	print('Purchasing item: ', item_id)
	purchase_item(item_id)
