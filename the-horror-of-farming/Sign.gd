extends CharacterBody2D

@onready var interface = load("res://Scenes/artificer_interface.tscn")
var interfaceOpen = false
	
func townsfolk():
	pass
	
func interact():
	var artificerInterface = interface.instantiate()
	find_parent("World").find_child("UI Layer").add_child(artificerInterface)
