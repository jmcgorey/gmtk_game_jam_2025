extends CanvasLayer

@onready var start_button: Button = %StartGameButton
@onready var options_button: Button = %OptionsButton
@onready var credits_button: Button = %CreditsButton
@onready var quit_button: Button = %QuitButton

var options_scene = preload('res://scenes/ui/menus/options_menu.tscn')


func _ready() -> void:
	hide_quit_button_if_needed()
	
	# Connect event handlers
	start_button.pressed.connect(_on_start_pressed)
	options_button.pressed.connect(_on_options_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


## On some platforms, quit doesn't do anything.  If running on one of those
## platforms, hide the quit button
func hide_quit_button_if_needed() -> void:
	var should_show_button = ProjectSettings.get_setting_with_override("global/show_quit_button")
	quit_button.visible = should_show_button


func remove_child_scene(child_scene: Node) -> void:
	if child_scene != null:
		child_scene.queue_free()

## Happens when the "Start" button is pressed
func _on_start_pressed() -> void:
	print('Starting game')
	pass


## Happens when the "Options" button is pressed
func _on_options_pressed() -> void:
	print('Opening options')
	var options_instance: OptionsMenu = options_scene.instantiate()
	add_child(options_instance)
	options_instance.options_closed.connect(remove_child_scene.bind(options_instance))


## Happens when the "Credits" button is pressed
func _on_credits_pressed() -> void:
	print('Opening credits')
	pass


## Happens when the "Quit" button is pressed
func _on_quit_pressed() -> void:
	print('Quitting game...')
	get_tree().quit()
