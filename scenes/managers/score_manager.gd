class_name ScoreManager extends Node

@export var active_item_tracker: ActiveItemTracker
@onready var score_timer: Timer = %ScoreTimer

var _last_score: int = 0
var avg_score_per_second: float


var package_count: float = 0.0

## Emitted when the package count changes. Passes along the new package count
signal package_count_changed(new_package_count: float, packages_per_second: float)

func _ready():
	score_timer.timeout.connect(on_score_timer_timeout)

## Increse the package count by n packages
func increment_package_count(increment: float) -> void:
	package_count = package_count + increment
	package_count_changed.emit(package_count, avg_score_per_second)


## Remove n packages from the package count
func decrement_package_count(decrement: float) -> void:
	package_count = package_count - decrement
	package_count_changed.emit(package_count, avg_score_per_second)


## Tick the score based on purchased items and upgrades
func _tick_score():
	# Calculate the toal for each item in the active items array
	var sum = 0
	for item in active_item_tracker.get_all_items():
		sum += (item.count * item.items_per_second)
	
	# Apply any purchased upgrades
	# TODO - need upgrade tracking list
	
	# Calculate the avg score per second
	avg_score_per_second = (float(sum) + float(_last_score)) / 2
	print('Avg score: ', avg_score_per_second)
	_last_score = sum
	
	# Increment the counter
	increment_package_count(sum)


## Tick the score every time the timer times out
func on_score_timer_timeout():
	_tick_score()
