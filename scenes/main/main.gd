extends CanvasLayer

@onready var package_button: TextureButton = %PackageButton
@onready var package_count_label: Label = %PackageCountLabel
@onready var avg_count_label: Label = %AvgCountLabel

#@onready var progression_item_manager: ProgressionItemManager = %ProgressionItemManager
@onready var placeholder_shop: PlaceholderShop = $MarginContainer/VBoxContainer/HBoxContainer/StoreColumn/PanelContainer/PlaceholderShop
@onready var score_manager: ScoreManager = %ScoreManager

## The list of progression items for delivering packages
@export var progression_items: Array[ProgressionItem]


func _ready() -> void:
	package_button.pressed.connect(on_package_button_clicked)
	score_manager.package_count_changed.connect(on_package_count_changed)
	
	update_item_subscribers()


## Send the progression item list to all components that care about it
func update_item_subscribers():
	#progression_item_manager.set_items(progression_items)
	placeholder_shop.set_items(progression_items)


## Runs when the package icon is clicked
func on_package_button_clicked() -> void:
	score_manager.increment_package_count(1.0)


## Runs when the package count updates
func on_package_count_changed(new_count: float, avg_score_per_sec: float) -> void:
	package_count_label.text = str(floori(new_count))
	avg_count_label.text = str(floori(avg_score_per_sec)) + ' / sec' 
