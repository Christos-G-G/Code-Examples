# needs to be connected to levels

extends Control

# selectable by keyboard
func _ready():
	$MarginContainer/VBoxContainer/Resume.grab_focus()

# connect to level
func _on_resume_pressed():
	
	pass

# go to options menu
func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menus/options_menu.tscn")

# go to main menu
func _on_main_pressed():
	get_tree().change_scene_to_file("res://Menus/menu.tscn")
