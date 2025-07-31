class_name PlaceholderShop extends VBoxContainer

@export var progression_items: Array[ProgressionItem]

func set_items(items: Array[ProgressionItem]) -> void:
	progression_items = items
	
	for i in range(progression_items.size()):
		create_button(progression_items[i])


func create_button(item: ProgressionItem):
	var button_instance = Button.new()
	add_child(button_instance)
	button_instance.text = 'Add ' + item.display_name
	button_instance.autowrap_mode = TextServer.AUTOWRAP_WORD
	button_instance.pressed.connect(on_button_click.bind(item))


func on_button_click(item: ProgressionItem):
	item.quantity += 1
	GlobalEvents.emit_progression_item_changed(item)
