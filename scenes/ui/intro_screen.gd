extends CanvasLayer

@onready var start_button: Button = %StartButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.pressed.connect(on_start)


func on_start():
	# Load the main scene on start pressed
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
