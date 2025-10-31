extends Control

@export var moneyLabel : Label
@export var player : CharacterBody3D

@export var computer_screen: TextureRect
@export var buy_tab_button: Button
@export var buy_screen: TextureRect
@export var sell_tab_button: Button
@export var sell_screen: TextureRect

@export var radish_button: Button
@export var tomato_button: Button
@export var carrot_button: Button
@export var cauli_button: Button
@export var fertilizer_button: Button
@export var trap_button : Button

@export var radish_screen: NinePatchRect
@export var tomato_screen: NinePatchRect
@export var carrot_screen: NinePatchRect
@export var cauli_screen: NinePatchRect
@export var fertilizer_screen: NinePatchRect 
@export var trap_screen : NinePatchRect

@export var buy_radish_button: Button
@export var buy_tomato_button: Button
@export var buy_carrot_button: Button
@export var buy_cauli_button: Button
@export var buy_fertilizer_button: Button
@export var buy_trap_button : Button

var active_screen: NinePatchRect = null

@onready var audio_manager = $"/root/World/AudioManager"
@onready var tutorial_manager = get_node("/root/World/UI_Layer/tutorial_menu/tutorials")

@onready var tool_spawn_point = $"/root/World/3DHouse/ToolSpawnPoint"

var radishPrice : int = 5
var tomatoPrice : int = 12
var carrotPrice : int = 18
var cauliflowerPrice : int = 22
var fertilizerPrice : int = 10
var trapPrice : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buy_tab_button.pressed.connect(on_buy_tab_pressed)
	sell_tab_button.pressed.connect(on_sell_tab_pressed)
	set_active_tab(true)
	
	
	#Connects seed bags icons to respective purchase screen
	radish_button.pressed.connect(func(): show_item_screen(radish_screen))
	tomato_button.pressed.connect(func(): show_item_screen(tomato_screen))
	carrot_button.pressed.connect(func(): show_item_screen(carrot_screen))
	cauli_button.pressed.connect(func(): show_item_screen(cauli_screen))
	fertilizer_button.pressed.connect(func(): show_item_screen(fertilizer_screen))
	trap_button.pressed.connect(func(): show_item_screen(trap_screen))

	#Connects buy buttons
	buy_radish_button.pressed.connect(func(): attempt_purchase("Radish Seeds", radishPrice))
	buy_tomato_button.pressed.connect(func(): attempt_purchase("Tomato Seeds", tomatoPrice))
	buy_carrot_button.pressed.connect(func(): attempt_purchase("Carrot Seeds", carrotPrice))
	buy_cauli_button.pressed.connect(func(): attempt_purchase("Cauliflower Seeds", cauliflowerPrice))
	buy_fertilizer_button.pressed.connect(func(): attempt_purchase("Fertilizer", fertilizerPrice))
	buy_trap_button.pressed.connect(func(): attempt_purchase("Trap", trapPrice))

func on_buy_tab_pressed():
	audio_manager.button_click_sound()
	set_active_tab(true)


func on_sell_tab_pressed():
	audio_manager.button_click_sound()
	set_active_tab(false)
	

func set_active_tab(is_buying: bool):
	buy_screen.visible = is_buying
	sell_screen.visible = not is_buying
	buy_tab_button.disabled = is_buying
	sell_tab_button.disabled = not is_buying


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	moneyLabel.text = "YOU HAVE $" + str(player.money)
	pass

var trap_index := 20

func attempt_purchase(item_name: String, item_price: int):
	if item_name == "Trap":
		if player.money < item_price:
			print("Not Enough Money", item_name)
			return
			
		player.money -= item_price
		audio_manager.play_buy_sound()
		player.dropTool_fromShop("Trap%s" % trap_index, tool_spawn_point.global_position)
		trap_index += 1
		return
		
	if player.money >= item_price:
		player.money -= item_price
		PlayerInventory.add_item(item_name, 1)
		audio_manager.play_buy_sound()
		#call tutorial function
		tutorial_manager.check_tut_progress("Buy More Seeds")
		
	else:
		print("Not Enough Money", item_name)
	

func show_item_screen(screen: NinePatchRect):
	if active_screen:
		active_screen.visible = false
	screen.visible = true
	audio_manager.button_click_sound()
	active_screen = screen


func _on_sell_all_button_pressed() -> void:
	audio_manager.button_click_sound()
	PlayerInventory.sellAll()
	
func _on_xit_button_pressed() -> void:
	audio_manager.button_click_sound()
	close_computer_screen()

func close_computer_screen():
	find_parent("UI_Layer").closeShop()
	audio_manager.button_click_sound()



#func _on_buy_trap_pressed() -> void:
	#player.dropTool_fromShop("Trap%s" % trap_index, tool_spawn_point.global_position)
	#trap_index += 1
