class_name ItemDefinitionProvider extends Node


var item_definition_path
var item_definitions: Array[ItemDefinition] = []

signal definitions_loaded

func _ready() -> void:
	item_definition_path = ProjectSettings.get_setting_with_override("global/item_definition_path")
	load_item_definitions()

## Load all of the definitions from the `item_definition_path` and put them in memory
func load_item_definitions():
	var resource_paths = ResourceLoader.list_directory(item_definition_path)
	for path in resource_paths:
		var resource_path = item_definition_path + '/' + path
		var item_definition: ItemDefinition = ResourceLoader.load(resource_path, 'ItemDefinition')
		item_definitions.push_back(item_definition)
	
	definitions_loaded.emit()
