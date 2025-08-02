extends Node

var package_count: float = 0.0
var all_time_package_count: float = 0.0

signal package_count_changed(total_packages: float, all_time_packages: float, packages_per_second: float)
