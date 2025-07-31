extends CanvasLayer

@onready var package_button: TextureButton = %PackageButton
@onready var package_count_label: Label = %PackageCountLabel
@onready var timer: Timer = $Timer
@onready var test_pigeon_button: Button = %TestPigeonButton
@onready var test_paper_boy_button: Button = %TestPaperBoyButton

@onready var progression_items_container: ProgressionItemContainer = %ProgressionItemsContainer

@export var prog_item: ProgressionItem
@export var paper_boy_res: ProgressionItem
@export var progression_items: Array[ProgressionItem]


@onready var score_manager: ScoreManager = %ScoreManager


## TODO - Refactor button to just emit signal asking for increase
##		- Have some game state watcher that responds to signals

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	package_button.pressed.connect(on_package_button_clicked)
	score_manager.package_count_changed.connect(on_package_count_changed)
	timer.timeout.connect(on_timer_timeout)
	test_pigeon_button.pressed.connect(on_add_pigeon)
	test_paper_boy_button.pressed.connect(on_add_paper_boy)
	
	progression_items_container.set_progression_items(progression_items)

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


func on_add_paper_boy() -> void:
	paper_boy_res.quantity += 1
	GlobalEvents.emit_progression_item_changed(paper_boy_res)
