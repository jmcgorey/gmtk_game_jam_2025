class_name UpgradeDefinitionProvider extends Node


var upgrade_definition_path
var upgrade_definitions: Dictionary[String, BaseUpgrade] = {}

signal definitions_loaded

func _ready() -> void:
	upgrade_definition_path = ProjectSettings.get_setting_with_override("global/upgrade_definition_path")
	load_upgrade_definitions()

## Load all of the definitions from the `upgrade_definition_path` and put them in memory
func load_upgrade_definitions():
	var resource_paths = ResourceLoader.list_directory(upgrade_definition_path)
	for path in resource_paths:
		var resource_path = upgrade_definition_path + '/' + path
		var upgrade_definition: BaseUpgrade = ResourceLoader.load(resource_path)
		upgrade_definitions.set(upgrade_definition.id, upgrade_definition)
		print('Loaded upgrade: ' + upgrade_definition.debug())
	
	definitions_loaded.emit()


func get_definition(upgrade_id: String) -> BaseUpgrade:
	return upgrade_definitions.get(upgrade_id)


func get_all_definitions() -> Dictionary[String, BaseUpgrade]:
	if upgrade_definitions.is_empty():
		load_upgrade_definitions()
	
	return upgrade_definitions
