class_name ActiveItemCard extends MarginContainer

@export var item: ActiveItemTracker.ActiveItem

## Provides any needed updates to the card when the resource changes
func update_display() -> void:
	set_card_texture()
	set_card_label()


## Sets the card texture based on what the resource says it should be
func set_card_texture() -> void:
	if item != null:
		%BackgroundImage.texture = item.texture


## Sets the card label based on the resource name & quantity
func set_card_label() -> void:
	if item != null:
		var labelText = item.display_name + '   x' + str(item.count)
		%ItemNameLabel.text = labelText
