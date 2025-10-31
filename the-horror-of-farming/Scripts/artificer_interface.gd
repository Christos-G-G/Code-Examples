extends Control

const ItemClass = preload("res://Scripts/item.gd")
const SlotClass = preload("res://Scripts/Slot.gd")
@onready var interface = load("res://Scenes/artificer_interface.tscn")
@onready var artificer_slot = load("res://Scenes/artificer_slot.tscn").instantiate()

var holding_item = null

func _ready():
	var artSlot = artificer_slot.find_child("Slot")
	find_parent("UI Layer").inventory.add_child(artificer_slot)
	artSlot.gui_input.connect(find_parent("UI Layer").inventory.slot_gui_input.bind(artSlot))
	artSlot.slot_index = 0
	artSlot.slotType = SlotClass.SlotType.INTERFACE
	artificer_slot.position = Vector2(250, 50)
	find_parent("UI Layer").toggleInventory()
	$Timer.start()
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("interact") && $Timer.time_left == 0:
		if artificer_slot.get_child(0).get_child_count() == 0:
			find_parent("UI Layer").toggleInventory()
			PlayerInventory.interface_open = false
			artificer_slot.queue_free()
			queue_free()
		else:
			pass #Return item to inventory

func _on_a_1_option_1_pressed():
	$"Ability1/A1 Option 2".button_pressed = false
	$"Ability1/A1 Option 3".button_pressed = false
	$"Ability1/A1 Option 4".button_pressed = false
	$"Ability1/A1 Option 5".button_pressed = false
	$"Ability1/A1 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability1 = 1

func _on_a_1_option_2_pressed():
	$"Ability1/A1 Option 1".button_pressed = false
	$"Ability1/A1 Option 3".button_pressed = false
	$"Ability1/A1 Option 4".button_pressed = false
	$"Ability1/A1 Option 5".button_pressed = false
	$"Ability1/A1 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability1 = 2

func _on_a_1_option_3_pressed():
	$"Ability1/A1 Option 1".button_pressed = false
	$"Ability1/A1 Option 2".button_pressed = false
	$"Ability1/A1 Option 4".button_pressed = false
	$"Ability1/A1 Option 5".button_pressed = false
	$"Ability1/A1 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability1 = 3

func _on_a_1_option_4_pressed():
	$"Ability1/A1 Option 1".button_pressed = false
	$"Ability1/A1 Option 2".button_pressed = false
	$"Ability1/A1 Option 3".button_pressed = false
	$"Ability1/A1 Option 5".button_pressed = false
	$"Ability1/A1 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability1 = 4

func _on_a_1_option_5_pressed():
	$"Ability1/A1 Option 1".button_pressed = false
	$"Ability1/A1 Option 2".button_pressed = false
	$"Ability1/A1 Option 3".button_pressed = false
	$"Ability1/A1 Option 4".button_pressed = false
	$"Ability1/A1 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability1 = 5

func _on_a_1_option_6_pressed():
	$"Ability1/A1 Option 1".button_pressed = false
	$"Ability1/A1 Option 2".button_pressed = false
	$"Ability1/A1 Option 3".button_pressed = false
	$"Ability1/A1 Option 4".button_pressed = false
	$"Ability1/A1 Option 5".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability1 = 6


func _on_a_2_option_1_pressed():
	$"Ability2/A2 Option 2".button_pressed = false
	$"Ability2/A2 Option 3".button_pressed = false
	$"Ability2/A2 Option 4".button_pressed = false
	$"Ability2/A2 Option 5".button_pressed = false
	$"Ability2/A2 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability2 = 1

func _on_a_2_option_2_pressed():
	$"Ability2/A2 Option 1".button_pressed = false
	$"Ability2/A2 Option 3".button_pressed = false
	$"Ability2/A2 Option 4".button_pressed = false
	$"Ability2/A2 Option 5".button_pressed = false
	$"Ability2/A2 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability2 = 2

func _on_a_2_option_3_pressed():
	$"Ability2/A2 Option 1".button_pressed = false
	$"Ability2/A2 Option 2".button_pressed = false
	$"Ability2/A2 Option 4".button_pressed = false
	$"Ability2/A2 Option 5".button_pressed = false
	$"Ability2/A2 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability2 = 3

func _on_a_2_option_4_pressed():
	$"Ability2/A2 Option 1".button_pressed = false
	$"Ability2/A2 Option 2".button_pressed = false
	$"Ability2/A2 Option 3".button_pressed = false
	$"Ability2/A2 Option 5".button_pressed = false
	$"Ability2/A2 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability2 = 4

func _on_a_2_option_5_pressed():
	$"Ability2/A2 Option 1".button_pressed = false
	$"Ability2/A2 Option 2".button_pressed = false
	$"Ability2/A2 Option 3".button_pressed = false
	$"Ability2/A2 Option 4".button_pressed = false
	$"Ability2/A2 Option 6".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability2 = 5

func _on_a_2_option_6_pressed():
	$"Ability2/A2 Option 1".button_pressed = false
	$"Ability2/A2 Option 2".button_pressed = false
	$"Ability2/A2 Option 3".button_pressed = false
	$"Ability2/A2 Option 4".button_pressed = false
	$"Ability2/A2 Option 5".button_pressed = false
	if artificer_slot.get_child(0).get_child(0) != null:
		artificer_slot.get_child(0).get_child(0).ability2 = 6
