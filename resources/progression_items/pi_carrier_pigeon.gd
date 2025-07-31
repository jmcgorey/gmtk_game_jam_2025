extends ProgressionItem


## Returns the Texture2D that should be displayed as the background image
## `null` is returned if no images are set
func get_background_image() -> Texture2D:
	print('In Pigeon background function')
	if background_images.size() > 0:
		return background_images[0]
	return null
