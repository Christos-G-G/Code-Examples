extends Node2D

var item_name : String
var item_quantity : int

func _ready():
	pass

func set_item(itemName, quantity):
	item_name = itemName
	item_quantity = quantity
	$TextureRect.texture = load("res://Art/objects/" + item_name + ".png")
	updateText()
	if ItemData.item_data[itemName]["ItemCategory"] == "Seeds":
		$TextureRect.scale = Vector2(0.25, 0.25)
	else:
		$TextureRect.scale = Vector2(0.5, 0.5)
	
func updateText():
	if item_quantity == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = str(item_quantity)
		
func add_item_quantity(amount):
	item_quantity += amount
	$Label.text = str(item_quantity)
	updateText()

func decrease_item_quantity(amount):
	item_quantity -= amount
	$Label.text = str(item_quantity)
	updateText()
	
func set_item_quantity(amount):
	item_quantity = amount
	$Label.text = str(item_quantity)
	updateText()
	
func copy(other):
	item_name = other.item_name
	item_quantity = other.item_quantity
