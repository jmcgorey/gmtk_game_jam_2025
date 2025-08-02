extends Node

@onready var package_button: TextureButton = %PackageButton
@onready var package_count_label: Label = %PackageCountLabel

@export var score_manager: ScoreManager


func _ready() -> void:
	package_button.pressed.connect(on_package_button_clicked)
	ScoreState.package_count_changed.connect(on_package_count_changed)


## Runs when the package icon is clicked
func on_package_button_clicked() -> void:
	score_manager.increment_package_count(1.0)


## Runs when the package count updates
func on_package_count_changed(new_count: float, _all_time_count: float, _avg_score_per_sec: float) -> void:
	package_count_label.text = NumberFormatter.get_pretty_string(new_count)
