extends Control

const ItemClass = preload("res://Scripts/item.gd")
const SlotClass = preload("res://Scripts/Slot.gd")
@onready var inventory_slots = $Inventory
@onready var item_information = load("res://Scenes/item_information.tscn").instantiate()
@export var toolSlot : Panel
@export var uiLayer : CanvasLayer
@onready var tutorial_manager = get_node("/root/World/UI_Layer/tutorial_menu/tutorials")
var holding_item = null
var current_slot
var open = true
var startSlot
var curHotbarSlot = 1
var hotbarSlots
# Called when the node enters the scene tree for the first time.
func _ready():
	var slots = inventory_slots.get_children()
	var slotNum = 0
	for inv_slot in inventory_slots.get_children():
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))
		inv_slot.mouse_entered.connect(mouse_entered_slot.bind(inv_slot))
		inv_slot.mouse_exited.connect(mouse_exited_slot.bind(inv_slot))
		slots[slotNum].slot_index = slotNum
		slots[slotNum].slotType = SlotClass.SlotType.INVENTORY
		slotNum += 1
	
	initialize_inventory()
	hotbarSlots = [$Inventory/Slot1, $Inventory/Slot2, $Inventory/Slot3, $Inventory/Slot4]
	
	uiLayer = find_parent("UI Layer")
	PlayerInventory.updateInventory.connect(initialize_inventory)

func _process(_delta: float) -> void:
	if toolSlot.currentTool == "None":
		$Inventory.modulate = Color(1.0, 1.0, 1.0, 1.0)
		if curHotbarSlot == 0:
			$ToolSlot.modulate = Color(1.0, 1.0, 1.0, 1.0)
			curHotbarSlot = 1
		match curHotbarSlot:
			1:
				$Inventory/Slot1.modulate = Color(1.0, 1.0, 0.5, 1.0)
				$Inventory/Slot2.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot3.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot4.modulate = Color(1.0, 1.0, 1.0, 1.0)
			2:
				$Inventory/Slot1.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot2.modulate = Color(1.0, 1.0, 0.5, 1.0)
				$Inventory/Slot3.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot4.modulate = Color(1.0, 1.0, 1.0, 1.0)
			3:
				$Inventory/Slot1.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot2.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot3.modulate = Color(1.0, 1.0, 0.5, 1.0)
				$Inventory/Slot4.modulate = Color(1.0, 1.0, 1.0, 1.0)
			4:
				$Inventory/Slot1.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot2.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot3.modulate = Color(1.0, 1.0, 1.0, 1.0)
				$Inventory/Slot4.modulate = Color(1.0, 1.0, 0.5, 1.0)
		if !open:
			if Input.is_action_just_pressed("InvSlot1"):
				curHotbarSlot = 1
				PlayerInventory.currentSlot = 1
			if Input.is_action_just_pressed("InvSlot2"):
				curHotbarSlot = 2
				PlayerInventory.currentSlot = 2
			if Input.is_action_just_pressed("InvSlot3"):
				curHotbarSlot = 3
				PlayerInventory.currentSlot = 3
			if Input.is_action_just_pressed("InvSlot4"):
				curHotbarSlot = 4
				PlayerInventory.currentSlot = 4
				tutorial_manager.check_tut_progress("Select Radish Seed")
			if Input.is_action_just_pressed("InventoryNextSlot"):
				if curHotbarSlot != 4:
					curHotbarSlot += 1
					PlayerInventory.currentSlot += 1
				else:
					curHotbarSlot = 1
					PlayerInventory.currentSlot = 1
			if Input.is_action_just_pressed("InventoryPreviousSlot"):
				if curHotbarSlot != 1:
					curHotbarSlot -= 1
					PlayerInventory.currentSlot -= 1
				else:
					curHotbarSlot = 4
					PlayerInventory.currentSlot = 4
		pass
	else:
		curHotbarSlot = 0
		$Inventory/Slot1.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$Inventory/Slot2.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$Inventory/Slot3.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$Inventory/Slot4.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$ToolSlot.modulate = Color(1.0, 1.0, 0.5, 1.0)
		$Inventory.modulate = Color(0.25, 0.25, 0.25, 1.0)
	
func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
		else:
			if slots[i].item != null:
				slots[i].remove_child(slots[i].item)
				slots[i].item = null
	
func slot_gui_input(event: InputEvent, slot: SlotClass):
	if Input.is_action_just_pressed("LeftClick") && open:
		if holding_item != null && able_to_put_into_slot(slot):
			if !slot.item:
				insert_into_empty_slot(slot)
			else:
				if holding_item.item_name != slot.item.item_name: #Different item, Swap
					trade_items(event, slot)
				else: #Same Item, and Stackable?
					stack_items(slot)
		elif slot.item: #Grab New Item
			acquire_item(slot)
	#Unfinished Code for handling splitting stacks, taking one item, drag to spread items across slots, etc.
	'''elif Input.is_action_just_pressed("rightclick"):
		if holding_item != null:
			if !slot.item:
				if holding_item.item_quantity > 1:
					slot.putOneIntoNewSlot(holding_item)
					holding_item.decrease_item_quantity(1)
				else:
					slot.putIntoSlot(holding_item)
					holding_item = null
			elif holding_item.item_name == slot.item.item_name:
				var stack_size = int(ItemData.item_data[slot.item.item_name]["StackSize"])
				if slot.item.item_quantity < stack_size:
					if holding_item.item_quantity > 1:
						slot.item.add_item_quantity(1)
						holding_item.decrease_item_quantity(1)
					else:
						slot.item.add_item_quantity(1)
						holding_item.queue_free()
						holding_item = null	
		elif slot.item:
			if slot.item.item_quantity > 1:
				holding_item = ItemClass.instantiate()
				holding_item.copy(slot.item)
				holding_item.set_item_quantity(1)
				slot.pickOneFromSlot()
			else:
				holding_item = slot.item
				slot.pickFromSlot()
			holding_item.global_position = Vector2(get_global_mouse_position().x - 8, get_global_mouse_position().y - 8)'''
	'''elif Input.is_action_pressed("rightclick"):
		if holding_item != null:
			if !slot.item:
				if holding_item.item_quantity > 1:
					slot.putIntoSlot(holding_item)
					slot.item.set_item_quantity(1)
					holding_item.decrease_item_quantity(1)
				else:
					slot.putIntoSlot(holding_item)
					holding_item = null'''

###SLOT INFO
var mouse_in_slot = false
		
func mouse_entered_slot(slot: SlotClass):
	if !mouse_in_slot && slot.item != null:
		mouse_in_slot = true
		display_item_info(slot)

func display_item_info(slot: SlotClass):
	var item_info = load("res://Scenes/item_information.tscn").instantiate()
	slot.add_child(item_info)
	current_slot = slot
	item_info.z_index = 5
	var item_label = item_info.get_child(0)
	item_label.text = str(slot.item.item_name)
	var boxLength = str(slot.item.item_name).length()
	item_info.size.x = boxLength * 5.5
	
func mouse_exited_slot(slot: SlotClass):
	if mouse_in_slot && slot.item != null && slot.get_child_count() > 1:
		current_slot = null
		remove_info(slot)
	pass

func remove_current_slot_info():
	mouse_in_slot = false
	if current_slot != null:
		if current_slot.get_child_count() > 0:
			current_slot.get_child(current_slot.get_child_count() - 1).queue_free()
		
func remove_info(slot: SlotClass):
	mouse_in_slot = false
	if slot.get_child_count() > 0:
		slot.get_child(slot.get_child_count() - 1).queue_free()

###ITEM MANAGEMENT
func able_to_put_into_slot(slot: SlotClass):
	if holding_item == null:
		return true
	else:
		var holding_item_category = ItemData.item_data[holding_item.item_name]["ItemCategory"]
		match slot.slotType:
			SlotClass.SlotType.INTERFACE:
				return holding_item_category == "Weapon"
			SlotClass.SlotType.INVENTORY:
				return true
	
func insert_into_empty_slot(slot: SlotClass):
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	slot.putIntoSlot(holding_item)
	holding_item = null
	mouse_in_slot = true
	display_item_info(slot)
	
func trade_items(event: InputEvent, slot: SlotClass):
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	remove_info(slot)
	temp_item.global_position = event.global_position
	slot.putIntoSlot(holding_item)
	holding_item = temp_item
	
func stack_items(slot: SlotClass):
	var stack_size = int(ItemData.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= holding_item.item_quantity:
		PlayerInventory.stack_items(slot, holding_item.item_quantity)
		slot.item.add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free()
		holding_item = null
	else:	
		PlayerInventory.stack_items(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add)
		holding_item.decrease_item_quantity(able_to_add)
	
func acquire_item(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	holding_item = slot.item
	slot.pickFromSlot()
	remove_info(slot)
	startSlot = slot
	holding_item.global_position = Vector2(get_global_mouse_position().x - 8, get_global_mouse_position().y - 8)
	
func _input(_event):
	if holding_item:
		holding_item.global_position = Vector2(get_global_mouse_position().x - 8, get_global_mouse_position().y - 8)
		
func toggleOpen():
	if holding_item:
		insert_into_empty_slot(startSlot)
	open = !open
	if open:
		$ToggleInventory.icon = load("res://Art/ui/BagButtonOpen.png")
	else:
		$ToggleInventory.icon = load("res://Art/ui/BagButtonClosed.png")
	$Background.visible = !$Background.visible
	$Inventory/Slot5.visible = !$Inventory/Slot5.visible
	$Inventory/Slot6.visible = !$Inventory/Slot6.visible
	$Inventory/Slot7.visible = !$Inventory/Slot7.visible
	$Inventory/Slot8.visible = !$Inventory/Slot8.visible
	$Inventory/Slot9.visible = !$Inventory/Slot9.visible
	$Inventory/Slot10.visible = !$Inventory/Slot10.visible
	$Inventory/Slot11.visible = !$Inventory/Slot11.visible
	$Inventory/Slot12.visible = !$Inventory/Slot12.visible
		
	
	pass

func _on_toggle_inventory_pressed() -> void:
	find_parent("World").find_child("UI_Layer").toggleInventory()
	pass # Replace with function body.
