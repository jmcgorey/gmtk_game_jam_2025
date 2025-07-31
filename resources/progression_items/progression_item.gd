class_name ProgressionItem extends Resource

## The id of the item
@export var id: String

## The display name of the item
@export var display_name: String

## The number of times this item has been purchased
@export var quantity: int = 0

## The base cost of the item
@export var cost: float = 0

## The number of packages this deliver each time it procs
@export var packages_per_increment: float = 0

## The time it takes for this item proc (in seconds)
@export var seconds_per_increment: float = 0

## The possible background images that can be shown for this item
@export var background_images: Array[Texture2D]


## Returns the Texture2D that should be displayed as the background image
## `null` is returned if no images are set
func get_background_image() -> Texture2D:
	if background_images.size() > 0:
		return background_images[0]
	return null


## Returns how much it costs to purchase the next item of this type
func get_cost() -> float:
	if quantity == 0:
		return cost
	
	return ceili(cost * quantity * 1.5) #placeholder
