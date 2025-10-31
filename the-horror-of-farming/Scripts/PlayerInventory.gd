extends Node

var num_inventory_slots : int = 12
const ItemClass = preload("res://Scripts/item.gd")
const SlotClass = preload("res://Scripts/Slot.gd")
var interface_open : bool = false
var currentSlot : int = 1

signal updateInventory()
signal addMoney(money)

@onready var tutorial_manager = get_node("/root/World/UI_Layer/tutorial_menu/tutorials")

var inventory = {
	#slot index: ["item name", item quantity]
	3: ["Radish Seeds", 5],
}


###-----NORMAL ITEM HANDLING
func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(ItemData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				updateInv()
				return
			elif able_to_add != 0:	
				inventory[item][1] += able_to_add
				item_quantity -= able_to_add	
			
	for i in range(num_inventory_slots):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			updateInv()
			return
	updateInv()

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func remove_item(slot: SlotClass):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory.erase(slot.slot_index)
	
func stack_items(slot: SlotClass, amount: int):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index][1] += amount
	
func sellAll():
	var sellValue = 0
	var removedItems = []
	for item in inventory:
		if ItemData.item_data[inventory[item][0]]["ItemCategory"] == "Resource":
			sellValue += inventory[item][1] * int(ItemData.item_data[inventory[item][0]]["Value"])
			removedItems.append(item)
	for removeIndex in removedItems:
		inventory.erase(removeIndex)
	updateInv()
	emit_signal("addMoney", sellValue)
	

func updateInv():
	emit_signal("updateInventory")
