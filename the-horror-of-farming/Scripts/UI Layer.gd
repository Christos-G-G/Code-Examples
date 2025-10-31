extends CanvasLayer

var inventoryOpen : bool = false
var shopOpen : bool = false

@onready var inventory = (load("res://Scenes/inventory.tscn")).instantiate()
@onready var news : PackedScene = preload("res://news_popup.tscn")
@onready var audio_manager = $"/root/World/AudioManager"

@export var shop : Control
@export var player : CharacterBody3D
@export var menu : Control

func _ready():
	add_child(inventory)
	inventory.z_index = 5
	inventory.toggleOpen()
	player.inventory = inventory
	player.toolSlot = inventory.find_child("ToolSlot")
	
	var x_button = shop.get_node("ComputerBG/XitButton")
	if x_button:
		x_button.pressed.connect(closeShop)

func _process(_delta):
	if Input.is_action_just_pressed("Inventory") && !PlayerInventory.interface_open:
		toggleInventory()
		if shopOpen and !inventoryOpen:
			closeShop()
			menu.show()
		

func toggleInventory():
	inventory.initialize_inventory()
	if inventoryOpen:
		inventory.remove_current_slot_info()
		inventory.toggleOpen()
		inventoryOpen = false
	else:
		inventory.toggleOpen()
		inventoryOpen = true

func openShop():
	if !shopOpen:
		audio_manager.button_click_sound()
		shop.visible = true
		shop.show()
		shopOpen = true
		menu.hide()
	else:
		print("Shop already open")


func closeShop():
	print("Closing Shop")
	audio_manager.button_click_sound()
	shop.visible = false
	shopOpen = false
	menu.show()

var news_shown := 0

var news_texts = [
	"Is Brightroot farm making a comeback? Selection of fresh veggies available at the local market",
	"Locals Thrilled With Brightroot Farm Revival! Markets Overflowing!",
	"A new flu is on the rise. Here are the signs that you might have it!",
	"Local Hospitals Report Increase in Unexplained Illnesses. More Bedridden",
	"Lockdown declared! No one is allowed to leave their house!",
	"This... is... your... fault..."
]

func add_news() -> void:
	var _news = news.instantiate()
	add_child(_news)
	
	if news_shown > news_texts.size() - 1:
		news_shown = news_texts.size() -1
	
	_news.set_text(news_texts[news_shown])
	news_shown += 1
