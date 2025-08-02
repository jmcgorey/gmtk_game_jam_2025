extends Node

@export var active_item_tracker: ActiveItemTracker
@export var item_definition_provider: ItemDefinitionProvider
@export var shop_item_tracker: ShopItemTracker
@onready var shop_items_viewer: VBoxContainer = $ShopItemsViewer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop_items_viewer.set_item_tracker(shop_item_tracker)
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


func _sort_by_store_slot_asc(def1: ItemDefinition, def2: ItemDefinition) -> int:
	return def1.store_slot < def2.store_slot
