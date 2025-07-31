extends MarginContainer

@export var progression_item: ProgressionItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEvents.progression_item_changed.connect(on_progression_item_changed)
	update_display()


## Provides any needed updates to the card when the resource changes
func update_display() -> void:
	hide_card_if_needed()
	set_card_texture()
	set_card_label()

## Hides the card if the quantity is <= 0
func hide_card_if_needed() -> void:
	if progression_item == null || progression_item.quantity <= 0:
		visible = false
	else:
		visible = true

## Sets the card texture based on what the resource says it should be
func set_card_texture() -> void:
	if progression_item != null:
		%BackgroundImage.texture = progression_item.get_background_image()


## Sets the card label based on the resource name & quantity
func set_card_label() -> void:
	if progression_item != null:
		var labelText = progression_item.display_name + '   x' + str(floori(progression_item.quantity))
		%ItemNameLabel.text = labelText

## If a progression item updates and it belongs to this card, update the view
func on_progression_item_changed(item: ProgressionItem) -> void:
	if progression_item == null:
		return
	
	if item.id == progression_item.id:
		update_display()
