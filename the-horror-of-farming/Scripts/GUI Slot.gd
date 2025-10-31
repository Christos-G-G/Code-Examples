extends Panel

const ItemClass = preload("res://Scenes/item.tscn")
var item = null
var slot_index = 1

enum SlotType {
	INVENTORY,
	INTERFACE
}

var slotType = SlotType.INTERFACE

func pickFromSlot():
	$"../../PickSound".play()
	remove_child(item)
	var inventoryNode = find_parent("Inventories")
	inventoryNode.add_child(item)
	item = null

func putIntoSlot(new_item):
	$"../../PlaceSound".play()
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventories")
	inventoryNode.remove_child(item)
	add_child(item)
	print(str(item.global_position))
