class_name OptionsMenu extends CanvasLayer

## Options menu to adjust the settings for the game, including
## - volume settings
##
## Heavily inspired by the Options Menu from Firebelley Games' 2D Survivors Course
## https://www.udemy.com/course/create-a-complete-2d-arena-survival-roguelike-game-in-godot-4/

@onready var back_button: Button = %BackButton
@onready var master_volume_slider: HSlider = %MasterVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = %SfxVolumeSlider

const BUS_NAME_MASTER = 'Master'
const BUS_NAME_MUSIC = 'Music'
const BUS_NAME_SFX = 'SFX'

## Emits when the options screen finishes opening
signal options_opened

## Emits when the "back" button is clicked
signal options_closed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hook up event handlers
	master_volume_slider.value_changed.connect(_on_audio_slider_changed.bind(BUS_NAME_MASTER))
	music_volume_slider.value_changed.connect(_on_audio_slider_changed.bind(BUS_NAME_MUSIC))
	sfx_volume_slider.value_changed.connect(_on_audio_slider_changed.bind(BUS_NAME_SFX))
	
	back_button.pressed.connect(_on_back_button_pressed)
	
	# Update the sliders to reflect their saved values
	update_display()
	
	# Emit the options opened signal to let listeners know setup is done
	options_opened.emit()

## Updates the controls on the display to reflect their values
func update_display() -> void:
	# Update audio sliders
	master_volume_slider.value = get_bus_volume_percent(BUS_NAME_MASTER)
	music_volume_slider.value = get_bus_volume_percent(BUS_NAME_MUSIC)
	sfx_volume_slider.value = get_bus_volume_percent(BUS_NAME_SFX)


## Returns the volume of the given Audio Bus as a percentage
func get_bus_volume_percent(bus_name: String) -> float:
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


## Sets the target audio bus to the specified percent
func set_bus_volume_percent(bus_name: String, value: float) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_linear(bus_index, value)


## Fires when one of the audio sliders changes value
func _on_audio_slider_changed(value: float, bus_name: String) -> void:
	set_bus_volume_percent(bus_name, value)


## Fires when the "Back" button is pressed
func _on_back_button_pressed() -> void:
	options_closed.emit()
