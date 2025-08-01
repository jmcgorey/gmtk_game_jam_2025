class_name ProgressionItemContainer extends VBoxContainer

@export var item_tracker: ActiveItemTracker
@export var card_scene: PackedScene

@onready var item_card_container: VBoxContainer = %ItemCardContainer


func _ready():
	item_tracker.items_changed.connect(on_active_items_changed)


func reset_view(items: Array[ActiveItemTracker.ActiveItem]):
	# Wipe out all existing cards
	clear_cards()
	
	# Create a new card for each item in the list
	for item in items:
		create_card(item)


func clear_cards():
	var children = item_card_container.get_children()
	for child in children:
		if is_instance_valid(child):
			child.queue_free()


func create_card(item: ActiveItemTracker.ActiveItem):
	var card_instance: ActiveItemCard = card_scene.instantiate()
	card_instance.item = item
	item_card_container.add_child(card_instance)
	card_instance.update_display()


func on_active_items_changed():
	var items = item_tracker.get_all_items()
	reset_view(items)
