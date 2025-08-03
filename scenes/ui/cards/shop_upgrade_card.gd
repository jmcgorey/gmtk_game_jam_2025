class_name ShopUpgradeCard extends MarginContainer

@export var texture: Texture2D

@onready var upgrade_button: Button = %UpgradeButton
@onready var name_label: Label = %NameLabel
@onready var cost_label: Label = %CostLabel
@onready var upgrade_texture: TextureRect = %UpgradeTexture
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var stored_upgrade: ShopUpgradeTracker.ShopUpgrade
signal upgrade_button_pressed(item_id)

func _ready():
	upgrade_button.pressed.connect(on_upgrade_button_pressed)
	ScoreState.package_count_changed.connect(on_package_count_changed)

# Called when the node enters the scene tree for the first time.
func set_properties(upgrade: ShopUpgradeTracker.ShopUpgrade) -> void:
	upgrade_texture.texture = upgrade.texture
	name_label.text = upgrade.display_name
	cost_label.text = NumberFormatter.get_pretty_string(upgrade.cost)
	stored_upgrade = upgrade
	
	set_enabled(ScoreState.package_count)


# Sets the shop item card to be enabled/disabled based on if we have enough
# score to pay for it
func set_enabled(score: float):
	if score < stored_upgrade.cost:
		upgrade_button.disabled = true
	else:
		upgrade_button.disabled = false
	

func on_upgrade_button_pressed():
	audio_stream_player.play()
	await audio_stream_player.finished
	upgrade_button_pressed.emit(stored_upgrade.id)

func on_package_count_changed(pkg_count: float, _all_time_pkgs: float, _avg_pkgs: float):
	set_enabled(pkg_count)
