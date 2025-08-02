extends PanelContainer

@onready var all_time_value: Label = %AllTimeValue
@onready var per_second_value: Label = %PerSecondValue
@onready var delivery_methods_container: VBoxContainer = %DeliveryMethodsContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreState.package_count_changed.connect(on_score_changed)


# Updates the tracking labels when the score changes
func on_score_changed(_cur_score: float, all_time_score: float, score_per_sec: float):
	all_time_value.text = NumberFormatter.get_pretty_string(all_time_score)
	per_second_value.text = NumberFormatter.get_pretty_string(score_per_sec) + ' / sec'
