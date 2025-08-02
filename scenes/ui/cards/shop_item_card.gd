class_name ShopItemCard extends MarginContainer

@export var texture: Texture2D

@onready var item_button: Button = %ItemButton
@onready var name_label: Label = %NameLabel
@onready var cost_label: Label = %CostLabel
@onready var item_texture: TextureRect = %ItemTexture
@onready var count_label: Label = %CountLabel

var stored_id
signal item_button_pressed(item_id)

## TODO: Check if disabled or not - probably need to move score update into global sig

func _ready():
	item_button.pressed.connect(on_item_button_pressed)

# Called when the node enters the scene tree for the first time.
func set_properties(item: ShopItemTracker.ShopItem) -> void:
	item_texture.texture = item.texture
	name_label.text = item.display_name
	count_label.text = 'x' + str(item.count)
	cost_label.text = str(item.cost)
	stored_id = item.id
	

func on_item_button_pressed():
	item_button_pressed.emit(stored_id)
