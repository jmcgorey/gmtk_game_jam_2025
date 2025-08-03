extends PanelContainer

var options_scene = preload('res://scenes/ui/menus/options_menu.tscn')

@onready var options_button: TextureButton = %OptionsButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options_button.pressed.connect(_on_options_pressed)


## Closes the target menu scene
func remove_menu_scene(menu_scene: Node) -> void:
	if menu_scene != null && is_instance_valid(menu_scene):
		menu_scene.queue_free()


## Happens when the "Options" button is pressed
func _on_options_pressed() -> void:
	var options_instance: OverlayMenu = options_scene.instantiate()
	add_child(options_instance)
	options_instance.menu_closed.connect(remove_menu_scene.bind(options_instance))
