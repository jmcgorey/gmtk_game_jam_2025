extends Node

@export var progression_items: Array[ProgressionItem]
@export var score_manager: ScoreManager

@onready var timers: Node = %Timers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var num_items = progression_items.size()
	for i in range(num_items):
		init_timer(progression_items[i])

## Create a timer for a specific progression item
func init_timer(item: ProgressionItem) -> void:
	print('Initializing timer for item: ', item.id)
	
	var timer: Timer = Timer.new()
	timers.add_child(timer)
	timer.timeout.connect(on_item_timer_timeout.bind(item))
	timer.start(item.seconds_per_increment)


## On item proc, add the total to the package count
func on_item_timer_timeout(pi: ProgressionItem) -> void:
	if score_manager != null:
		print('Timeout for: ', pi.display_name)
		var num_packages = pi.quantity * pi.packages_per_increment
		if num_packages > 0:
			score_manager.increment_package_count(num_packages)
