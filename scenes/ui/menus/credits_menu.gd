extends OverlayMenu

## Credits menu to view credits for the game

@onready var back_button: Button = %BackButton


func _ready() -> void:
	# Hook up event handlers
	back_button.pressed.connect(_on_back_button_pressed)


## Fires when the "Back" button is pressed
func _on_back_button_pressed() -> void:
	close()
