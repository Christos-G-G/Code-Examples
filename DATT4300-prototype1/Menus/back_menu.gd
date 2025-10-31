# show controls / show credits 

extends Control

# selectable by keyboard
func _ready():
	$MarginContainer/VBoxContainer/Back.grab_focus()

# go back to Main Menu 
func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menus/menu.tscn")
