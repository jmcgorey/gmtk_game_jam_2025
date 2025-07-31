extends CanvasLayer

@onready var package_button: TextureButton = %PackageButton
@onready var package_count_label: Label = %PackageCountLabel
@onready var timer: Timer = $Timer
@onready var test_pigeon_button: Button = %TestPigeonButton

@export var prog_item: ProgressionItem

@onready var score_manager: ScoreManager = %ScoreManager


## TODO - Refactor button to just emit signal asking for increase
##		- Have some game state watcher that responds to signals

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	package_button.pressed.connect(on_package_button_clicked)
	score_manager.package_count_changed.connect(on_package_count_changed)
	timer.timeout.connect(on_timer_timeout)
	test_pigeon_button.pressed.connect(on_add_pigeon)

	if prog_item != null:
		prog_item.get_background_image()
		prog_item.get_cost()


func on_package_button_clicked() -> void:
	score_manager.increment_package_count(1.0)

func on_package_count_changed(new_count: float) -> void:
	package_count_label.text = str(floori(new_count))

func on_timer_timeout() -> void:
	score_manager.increment_package_count(2)


func on_add_pigeon() -> void:
	prog_item.quantity += 1
	GlobalEvents.emit_progression_item_changed(prog_item)
