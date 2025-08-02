class_name ShopUpgradeTracker extends BaseItemTracker


class ShopUpgrade extends BaseItemTracker.BaseItem:
	var cost: int
	var texture: Texture2D
	
	static func from_definition(def: BaseUpgrade):
		var upgrade = ShopUpgrade.new()
		
		upgrade.id = def.id
		upgrade.display_name = def.display_name
		upgrade.cost = def.cost
		upgrade.texture = def.texture
		
		return upgrade


## Returns the upgrade specified by `upgrade_id`.  Returns `null` if the
## desired upgrade is not present in the cache
func get_item(upgrade_id: String) -> ShopUpgrade:
	return super(upgrade_id) as ShopUpgrade


## Returns the list of all upgrades in the cache
func get_all_items() -> Array[ShopUpgrade]:
	# Convert type to ShopUpgrade to make Godot happy
	var upgrades: Array[ShopUpgrade] = []
	for upgrade: ShopUpgrade in super():
		upgrades.push_back(upgrade)
	
	return upgrades
