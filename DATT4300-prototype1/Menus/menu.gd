extends Control

# selectable by keyboard
func _ready():
	$MarginContainer/VBoxContainer/Play.grab_focus()

# connect to level
func _on_play_pressed():
	get_tree().change_scene_to_file("res://level.tscn")

# show controls menu
func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Menus/controls_menu.tscn")

# exit game
func _on_quit_pressed():
	get_tree().quit()

# go to page listing credits
func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Menus/credits.tscn")
