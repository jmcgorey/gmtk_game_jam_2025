class_name ProgressionItemContainer extends VBoxContainer

@export var progression_items: Array[ProgressionItem]
@export var card_scene: PackedScene


func set_progression_items(items: Array[ProgressionItem]) -> void:
	progression_items = items
	
	var num_items = items.size()
	for i in range(num_items):
		create_card(items[i])

func clear_cards():
	pass

func create_card(item: ProgressionItem):
	var card_instance: ProgressionItemCard = card_scene.instantiate()
	card_instance.progression_item = item
	add_child(card_instance)
