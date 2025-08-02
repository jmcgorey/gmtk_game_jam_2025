extends PanelContainer

@onready var all_time_value: Label = %AllTimeValue
@onready var per_second_value: Label = %PerSecondValue
@onready var delivery_methods_container: VBoxContainer = %DeliveryMethodsContainer

@export var active_items_tracker: ActiveItemTracker
@export var card_scene: PackedScene

var card_tracker: Dictionary[String, ActiveItemLineItem] = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreState.package_count_changed.connect(on_score_changed)
	active_items_tracker.items_changed.connect(on_items_changed)


# Reset the view for the active item cards
func update_item_cards():
	var items = active_items_tracker.get_all_items()
	
	for item in items:
		if card_tracker.has(item.id) && card_tracker[item.id] != null:
			card_tracker[item.id].set_item(item)
		else:
			var card_instance = create_item_card(item)
			card_tracker.set(item.id, card_instance)


# Create an item card and add it to the DeliveryMethodsContainer
func create_item_card(item: ActiveItemTracker.ActiveItem) -> ActiveItemLineItem:
	var card_instance: ActiveItemLineItem = card_scene.instantiate()
	delivery_methods_container.add_child(card_instance)
	card_instance.set_item(item)
	return card_instance


# Updates the tracking labels when the score changes
func on_score_changed(_cur_score: float, all_time_score: float, score_per_sec: float):
	all_time_value.text = NumberFormatter.get_pretty_string(all_time_score)
	per_second_value.text = NumberFormatter.get_pretty_string(score_per_sec) + ' / sec'


# Updates the item view whenever the list of active items changes 
func on_items_changed():
	update_item_cards()
