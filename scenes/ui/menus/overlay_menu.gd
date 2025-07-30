class_name OverlayMenu extends CanvasLayer

## OverlayMenu
## A helper layer for coordinating the "menu_closed" signal for multiple menu
## types. Expects a caller to instantiate the menu, then subscribe to the
## menu_closed signal so that it knows when to clean the menu up.

## Emits when it is time for the menu to be closed
signal menu_closed

## Notifies the caller to close the menu
func close() -> void:
	menu_closed.emit()

## Closes the menu when the `close_menu` action occurs
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("close_menu"):
		close()
