extends Node

signal progression_item_changed(item: ProgressionItem)

func emit_progression_item_changed(item: ProgressionItem):
	progression_item_changed.emit(item)
