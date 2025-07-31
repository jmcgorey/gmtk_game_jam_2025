extends CanvasLayer

@onready var start_button: Button = %StartGameButton
@onready var options_button: Button = %OptionsButton
@onready var credits_button: Button = %CreditsButton
@onready var quit_button: Button = %QuitButton

var options_scene = preload('res://scenes/ui/menus/options_menu.tscn')
var credits_scene = preload('res://scenes/ui/menus/credits_menu.tscn')


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


## Closes the target menu scene
func remove_menu_scene(menu_scene: Node) -> void:
	if menu_scene != null:
		menu_scene.queue_free()


## Happens when the "Start" button is pressed
func _on_start_pressed() -> void:
	print('Starting game')
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


## Happens when the "Options" button is pressed
func _on_options_pressed() -> void:
	print('Opening options')
	var options_instance: OverlayMenu = options_scene.instantiate()
	add_child(options_instance)
	options_instance.menu_closed.connect(remove_menu_scene.bind(options_instance))


## Happens when the "Credits" button is pressed
func _on_credits_pressed() -> void:
	print('Opening credits')
	var credits_instance: OverlayMenu = credits_scene.instantiate()
	add_child(credits_instance)
	credits_instance.menu_closed.connect(remove_menu_scene.bind(credits_instance))


## Happens when the "Quit" button is pressed
func _on_quit_pressed() -> void:
	print('Quitting game...')
	get_tree().quit()
