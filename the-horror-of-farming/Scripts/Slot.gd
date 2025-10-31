extends Panel

const ItemClass = preload("res://Scenes/item.tscn")
var item = null
var slot_index
var randomItem = RandomNumberGenerator.new()
@export var inventoryNode : Control

enum SlotType {
	INVENTORY,
	INTERFACE
}

var slotType = null

func _ready():
	pass

func _process(_delta):
	pass

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
		
func pickFromSlot():
	$"../../PickSound".play()
	remove_child(item)
	inventoryNode.add_child(item)
	item = null

func deleteItem():
	remove_child(item)
	item = null
	
func putIntoSlot(new_item):
	$"../../PlaceSound".play()
	item = new_item
	item.position = Vector2(0, 0)
	inventoryNode.remove_child(item)
	add_child(item)
		
func pickOneFromSlot():
	item.decrease_item_quantity(1)
		
func putOneIntoNewSlot(new_item):
	item.copy(new_item)
	item.position = Vector2(0, 0)
	item.set_item_quantity(1)
	add_child(item)
	
func putOneIntoSlot():
	item.add_item_quantity(1)
