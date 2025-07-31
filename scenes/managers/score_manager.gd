class_name ScoreManager extends Node

var package_count: float = 0.0

## Emitted when the package count changes. Passes along the new package count
signal package_count_changed(new_package_count: float)

## Increse the package count by n packages
func increment_package_count(increment: float) -> void:
	package_count = package_count + increment
	package_count_changed.emit(package_count)


## Remove n packages from the package count
func decrement_package_count(decrement: float) -> void:
	package_count = package_count - decrement
	package_count_changed.emit(package_count)
