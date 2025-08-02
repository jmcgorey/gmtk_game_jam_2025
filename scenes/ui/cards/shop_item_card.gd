class_name ShopItemCard extends MarginContainer

@export var texture: Texture2D

@onready var item_button: Button = %ItemButton
@onready var name_label: Label = %NameLabel
@onready var cost_label: Label = %CostLabel
@onready var item_texture: TextureRect = %ItemTexture
@onready var count_label: Label = %CountLabel

var stored_item: ShopItemTracker.ShopItem
signal item_button_pressed(item_id)

## TODO: Check if disabled or not - probably need to move score update into global sig

func _ready():
	item_button.pressed.connect(on_item_button_pressed)
	ScoreState.package_count_changed.connect(on_package_count_changed)

# Called when the node enters the scene tree for the first time.
func set_properties(item: ShopItemTracker.ShopItem) -> void:
	item_texture.texture = item.texture
	name_label.text = item.display_name
	count_label.text = 'x' + str(item.count)
	cost_label.text = str(item.cost)
	stored_item = item
	
	set_enabled(ScoreState.package_count)


func set_enabled(score: float):
	if score < stored_item.cost:
		item_button.disabled = true
	else:
		item_button.disabled = false
	

func on_item_button_pressed():
	item_button_pressed.emit(stored_item.id)

func on_package_count_changed(pkg_count: float, _avg_pkgs: float):
	set_enabled(pkg_count)
