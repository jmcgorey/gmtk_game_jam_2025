class_name PlaceholderShop extends VBoxContainer

@export var progression_items: Array[ProgressionItem]
@export var active_item_tracker: ActiveItemTracker

func _ready():
	set_items(progression_items)

func set_items(items: Array[ProgressionItem]) -> void:
	progression_items = items
	
	for i in range(progression_items.size()):
		create_button(progression_items[i])
	
	add_button('Test Upgrade').pressed.connect(on_test_upgrade)
	add_button('Debug').pressed.connect(on_debug_pressed)


func create_button(item: ProgressionItem):
	var button = add_button('Add ' + item.display_name)
	button.autowrap_mode = TextServer.AUTOWRAP_WORD
	button.pressed.connect(on_button_click.bind(item))


func add_button(text: String) -> Button:
	var button_instance = Button.new()
	add_child(button_instance)
	button_instance.text = text
	return button_instance

func on_button_click(item: ProgressionItem):
	item.quantity += 1
	GlobalEvents.emit_progression_item_changed(item)
	
	var active_item: ActiveItemTracker.ActiveItem = ActiveItemTracker.ActiveItem.new()
	active_item.id = item.id
	active_item.display_name = item.display_name
	active_item.count = item.quantity
	active_item.items_per_second = floori(item.packages_per_increment)
	active_item.texture = item.get_background_image()
	
	active_item_tracker.add_item(active_item)


func on_test_upgrade():
	# Task: Update pigeon to something else
	# For this example, let's just use a shuttle I guess
	var id_to_replace = 'carrier_pigeon'
	var prog_item: ProgressionItem
	for item in progression_items:
		if item.id == id_to_replace:
			prog_item = item
			break
	
	var new_item: ActiveItemTracker.ActiveItem = ActiveItemTracker.ActiveItem.new()
	new_item.id = 'well_fed_pigeon'
	new_item.display_name = '"Well Fed" Pigeon'
	new_item.count = floori(prog_item.quantity)
	new_item.items_per_second = 20
	
	active_item_tracker.replace_item(id_to_replace, new_item)


func on_debug_pressed():
	print('Item cache: ')
	for item in active_item_tracker.get_all_items():
		print(item.debug())
