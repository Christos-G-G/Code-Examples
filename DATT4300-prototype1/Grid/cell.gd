extends Node2D

# object occupying tile
@export var _occupant : Node
@onready var is_occupied = _occupant != null
var occupantType = 0
var hasEye = false

func add_occupant(new_occupant : Node) -> void:
	if _occupant != null:
		printerr("Cell %s attempted to add occupant to already occupied cell" % name)
		return
	
	_occupant = new_occupant
	if _occupant.type == 2:
		self.add_child(_occupant)
		occupantType = 2
	if _occupant.type == 3:
		self.add_child(_occupant)
		occupantType = 3
	is_occupied = true

func remove_occupant() -> void:
	if _occupant == null:
		printerr("Cell %s attempted to remove occupant from unoccupied cell" % name)
		return
	
	if _occupant.type == 2:
		self.remove_child(_occupant)
		occupantType = 0
	if _occupant.type == 3:
		self.remove_child(_occupant)
		occupantType = 0
	_occupant = null
	is_occupied = false

func get_occupant() -> Node:
	return _occupant

# coordinates
var coordinates : Vector2

func _ready() -> void:
	# coordinate setup from name
	if name == "x,y":
		printerr("Cell does not have name configured")
		return
	
	var string_components := name.split(",")
	coordinates = Vector2(	\
		string_components[0].to_int(),	\
		string_components[1].to_int()	\
	)
