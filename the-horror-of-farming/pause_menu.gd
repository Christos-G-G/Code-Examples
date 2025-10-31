extends MarginContainer

@export var menu_screen: VBoxContainer
@export var open_menu_screen: VBoxContainer
@export var controls_menu_screen: MarginContainer

@onready var audio_manager = $"/root/World/AudioManager"

func _ready() -> void:
	$ControlsMenuContainer/ControlsDisplay/ExitBox/XButton.pressed.connect(func(): _on_x_button_pressed(controls_menu_screen))

func toggle_visibility(object):
	if object.visible:
		object.visible = false
	else:
		object.visible = true


func _on_open_menu_button_pressed() -> void:
	toggle_visibility(menu_screen)
	toggle_visibility(open_menu_screen)
	audio_manager.play_open_menu_sound()

	get_tree().paused = menu_screen.visible

func _on_controls_button_pressed() -> void:
	audio_manager.button_click_sound()
	controls_menu_screen.show()
	

func _on_quit_button_pressed() -> void:
	audio_manager.button_click_sound()
	get_tree().quit()

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))


func _on_x_button_pressed(object) -> void:
	audio_manager.button_click_sound()
	controls_menu_screen.hide()
