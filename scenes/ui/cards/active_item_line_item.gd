class_name ActiveItemLineItem extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func set_item(item: ActiveItemTracker.ActiveItem):
	var item_velocity = item.count * item.items_per_second
	%ItemNameLabel.text = item.display_name + ' (' + NumberFormatter.get_pretty_string(item.count) + ')'
	%VelocityLabel.text = NumberFormatter.get_pretty_string(item_velocity) + ' / sec'
