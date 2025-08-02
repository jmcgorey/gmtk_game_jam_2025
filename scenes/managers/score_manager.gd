class_name ScoreManager extends Node

@export var active_item_tracker: ActiveItemTracker
@onready var score_timer: Timer = %ScoreTimer

var items_per_second: float

func _ready():
	score_timer.timeout.connect(on_score_timer_timeout)

## Increse the package count by n packages
func increment_package_count(increment: float) -> void:
	ScoreState.package_count += increment
	ScoreState.all_time_package_count += increment
	ScoreState.package_count_changed.emit(ScoreState.package_count, ScoreState.all_time_package_count, items_per_second)


## Remove n packages from the package count
func decrement_package_count(decrement: float) -> void:
	ScoreState.package_count = ScoreState.package_count - decrement
	ScoreState.package_count_changed.emit(ScoreState.package_count, ScoreState.all_time_package_count, items_per_second)


## Tick the score based on purchased items and upgrades
func _tick_score():
	# Calculate the toal for each item in the active items array
	var sum = 0
	for item in active_item_tracker.get_all_items():
		sum += (item.count * item.items_per_second)
	
	# Apply any purchased upgrades
	# TODO - need upgrade tracking list
	
	# Store the items generated this tick
	items_per_second = sum
	
	# Increment the counter
	increment_package_count(sum)


## Tick the score every time the timer times out
func on_score_timer_timeout():
	_tick_score()
