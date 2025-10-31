extends CharacterBody3D

@export var camera : Camera3D
@export var uiLayer : CanvasLayer
@export var uiDisplay : Label
@export var quotaDisplay: Label
@export var interactionLabel : Label
@export var world : Node3D

@export var playerArea : Area3D
@export var interactArea : Area3D

@export var dust_trail_vfx : GPUParticles3D

@export var maxStamina = 100
var curStamina = maxStamina

@onready var tutorial_manager = get_node("/root/World/UI_Layer/tutorial_menu/tutorials")

@onready var audio_manager = $"/root/World/AudioManager"

var speed = 20
var movementModifier = 1.0
var facing = "Down"
var pullFacing = "Down"
var money : int = 100

var item_near
var soil_near
var item_available : bool = false
var soil_available : bool = false
var can_sell : bool = false
var can_shop : bool = false
var can_fill_bucket : bool = false
var allowPickup : bool = true
var pullingVine : bool = false
var previous_rotation 
var usingTool = false

var quotaNotPaid : bool = true

var in_interface : bool = false

var vineTemplate = load("res://Scenes/vine.tscn")
var vine
var plantPos
var vinePlant

var input = Vector2.ZERO
var inventory = load("res://Scripts/inventory.gd")
var toolSlot
var groundTool = load("res://Scenes/ground_tool.tscn")
@export var anim : AnimatedSprite3D

func _ready():
	PlayerInventory.addMoney.connect(addMoney)
	pass
	
func _physics_process(delta):
	uiDisplay.text = "$" + str(money)
	quotaDisplay.text = "Quota: $" + str(Global.quota)
	#Prevents movement when an interface is open
	if camera.get_child_count() > 2:
		pass
	else:
		player_actions(delta)
	if curStamina <= 0:
		print("RESPAWNED!")
		self.position = Vector3(0, 0, 0)
		curStamina = maxStamina
	#Quota handling
	if Global.currentTime == Global.quotaTime && quotaNotPaid:
		quotaNotPaid = false
		money -= Global.quota
		Global.quota += 100
	if Global.currentTime == Global.quotaTime + 1:
		quotaNotPaid = true
	
	#Lantern light enable
	if toolSlot.currentTool == "Lantern":
		$LanternLight.visible = true
	else:
		$LanternLight.visible = false
	
func player_actions(_delta):
	input = get_input()
	if input == Vector2(0, 0) or uiLayer.inventoryOpen:
		if toolSlot.currentTool == "None":
			match facing:
				"Left":
					anim.play("IdleLeft")
				"Up":
					anim.play("IdleUp")
				"Right":
					anim.play("IdleRight")
				"Down":
					anim.play("IdleDown")
		elif !usingTool:
			anim.set_frame(0)
	
	
	if pullingVine:
		match pullFacing:
			"Left":
				anim.play("VinePullRight")
			"Up":
				anim.play("VinePullDown")
			"Right":
				anim.play("VinePullLeft")
			"Down":
				anim.play("VinePullUp")
		if input == Vector2(0, 0):
			anim.set_frame(0)
		pullVine()
		
	if item_available:
		if toolSlot.currentTool != "None":
			interactionLabel.text = "E - Exchange Tool"
		else:
			interactionLabel.text = "E - Obtain Tool"
	elif can_sell:
		interactionLabel.text = "E - Sell Item"
	elif can_shop:
		interactionLabel.text = "E - Open Shop"
	elif can_fill_bucket && inventory.toolSlot.currentTool == "Bucket":
		interactionLabel.text = "LClick - Fill Watering Can"
	elif soil_available:
			if inventory.curHotbarSlot != 0 && inventory.hotbarSlots[inventory.curHotbarSlot-1].item != null:
				if str(ItemData.item_data[inventory.hotbarSlots[inventory.curHotbarSlot-1].item.item_name]["ItemCategory"]) == "Seeds":
					interactionLabel.text = "LClick - Plant Seed"
			elif inventory.toolSlot.currentTool == "Hoe":
				interactionLabel.text = "LClick - Prepare Soil"
			elif inventory.curHotbarSlot == 0:
				interactionLabel.text = "LClick - Interact with Plant"
	else:
		interactionLabel.text = ""
	
	if toolSlot.currentTool != "None":
		interactionLabel.text += "\nF - Drop Tool"
		
	if Input.is_action_just_pressed("Interact") && !pullingVine && !uiLayer.inventoryOpen:
		if item_available: #E
			pickup_item()
		elif can_sell: #E
			sell_item()
		elif can_shop: #E
			uiLayer.openShop()
	if Input.is_action_just_pressed("LeftClick") && !pullingVine && !uiLayer.inventoryOpen:
		if can_fill_bucket && inventory.toolSlot.currentTool == "Bucket": #LClick
			inventory.toolSlot.data[2] = inventory.toolSlot.data[1]
			#call tutorial function
			tutorial_manager.check_tut_progress("Fill Water Can")
		elif soil_available: #LClick
			if inventory.curHotbarSlot != 0 && inventory.hotbarSlots[inventory.curHotbarSlot-1].item != null:
				var heldItem = ItemData.item_data[inventory.hotbarSlots[inventory.curHotbarSlot - 1].item.item_name]
				if str(heldItem["ItemCategory"]) == "Seeds":
					plant_seed()
				elif str(heldItem) == "Fertilizer":
					interact_with_plant()
			elif inventory.toolSlot.currentTool == "Hoe":
				usingTool = true
				match facing:
					"Left":
						anim.play("UseHoeLeft")
					"Up":
						anim.play("UseHoeUp")
					"Right":
						anim.play("UseHoeRight")
					"Down":
						anim.play("UseHoeDown")
				await(get_tree().create_timer(0.75).timeout)
				usingTool = false
				plant_seed()
			elif inventory.curHotbarSlot == 0:
				if inventory.toolSlot.currentTool == "Bucket":
					usingTool = true
					match facing:
						"Left":
							anim.play("UseBucketLeft")
						"Up":
							anim.play("UseBucketUp")
						"Right":
							anim.play("UseBucketRight")
						"Down":
							anim.play("UseBucketDown")
					await(get_tree().create_timer(0.75).timeout)
					usingTool = false
				interact_with_plant()
			
	if Input.is_action_just_pressed("DropTool") && toolSlot.currentTool != "None" && !pullingVine && !uiLayer.inventoryOpen:
		dropTool()

	if input == Vector2.ZERO:
		velocity = Vector3(input.x, 0, input.y)
		if dust_trail_vfx.emitting:
			dust_trail_vfx.emitting = false
	else:
		velocity = Vector3(input.x * speed * movementModifier, 0, input.y * speed * movementModifier)
		if !dust_trail_vfx.emitting:
			dust_trail_vfx.restart()
		if !audio_manager.player_walking_sfx():
			audio_manager.player_walking_sfx()
		else:
			audio_manager.stop_walking_sfx()
			
	if !uiLayer.inventoryOpen && !pullingVine:
		if Input.is_action_just_pressed("MoveLeft") || (input.x < 0 && input.y == 0):
			facing = "Left"
			match toolSlot.currentTool:
				"None":
					anim.play("LeftWalk")
				"Glove":
					anim.play("LeftWalkGloves")
				"Lantern":
					anim.play("LeftWalkLantern")
				"Bucket":
					anim.play("LeftWalkBucket")
				"Hoe":
					anim.play("LeftWalkHoe")
			$InteractArea.rotation.y = deg_to_rad(270)
		if Input.is_action_just_pressed("MoveUp") || (input.x == 0 && input.y < 0):
			facing = "Up"
			match toolSlot.currentTool:
				"None":
					anim.play("BackWalk")
				"Glove":
					anim.play("BackWalkGloves")
				"Lantern":
					anim.play("BackWalkLantern")
				"Bucket":
					anim.play("BackWalkBucket")
				"Hoe":
					anim.play("BackWalkHoe")
			$InteractArea.rotation.y = deg_to_rad(180)
		if Input.is_action_just_pressed("MoveRight") || (input.x > 0 && input.y == 0):
			facing = "Right"
			match toolSlot.currentTool:
				"None":
					anim.play("RightWalk")
				"Glove":
					anim.play("RightWalkGloves")
				"Lantern":
					anim.play("RightWalkLantern")
				"Bucket":
					anim.play("RightWalkBucket")
				"Hoe":
					anim.play("RightWalkHoe")
			$InteractArea.rotation.y = deg_to_rad(90)
		if Input.is_action_just_pressed("MoveDown") || (input.x == 0 && input.y > 0):
			facing = "Down"
			match toolSlot.currentTool:
				"None":
					anim.play("FrontWalk")
				"Glove":
					anim.play("FrontWalkGloves")
				"Lantern":
					anim.play("FrontWalkLantern")
				"Bucket":
					anim.play("FrontWalkBucket")
				"Hoe":
					anim.play("FrontWalkHoe")
			$InteractArea.rotation.y = deg_to_rad(0)
			
	###play_anim()
	move_and_slide()

func addMoney(addedMoney):
	money += addedMoney
	
func createVine(plant):
	var selfPos = self.global_position
	plantPos = plant.global_position
	vine = vineTemplate.instantiate()
	world.add_child(vine)
	vinePlant = plant
	pullVine()
	pass
	
func pullVine():
	var selfPos = self.global_position
	vine.global_transform.origin = (selfPos + plantPos) * 0.5
	vine.global_transform.origin.y += 3
	var distance = selfPos.distance_to(plantPos)
	vine.scale = Vector3(24.0, distance * 1.5, 24.0)
	var direction_vector = Vector2(selfPos.x - plantPos.x, selfPos.z - plantPos.z)
	var angle = atan2(direction_vector.y, direction_vector.x)
	var degAngle = rad_to_deg(angle)
	match degAngle:
		var dirAngle when dirAngle < -135:
			pullFacing = "Right"
		var dirAngle when dirAngle < -45:
			pullFacing = "Down"
		var dirAngle when dirAngle < 45:
			pullFacing = "Left"
		var dirAngle when dirAngle < 135:
			pullFacing = "Up"
		_:
			pullFacing = "Right"
	vine.rotation_degrees.y = 270 - degAngle
	movementModifier = remap(distance, 20.0, 3.0, 0.5, 1.0)
	if distance > 25.0:
		vine.queue_free()
		movementModifier = 1.0
		vinePlant.completeTask()
		vinePlant = null
		pullingVine = false
		audio_manager.play_snap_sound()
		
#--------------------------MOVEMENT, ANIMATION, ROLLING
func get_input():
	if !uiLayer.inventoryOpen:
		input.x = int(Input.is_action_pressed("MoveRight"))  - int(Input.is_action_pressed("MoveLeft"))
		input.y = int(Input.is_action_pressed("MoveDown")) - int(Input.is_action_pressed("MoveUp"))
		
	else:
		input.x = 0
		input.y = 0
	return input.normalized()

#------------------------INTERACTION, ITEM AND TOWNSFOLK
var items_in_range : Array
var soils_in_range : Array
var townsfolk_in_range
var nearby_townsfolk

func pickup_item():
	audio_manager.play_pickUp_sound()
	var near_item_index : int
	for i in items_in_range.size():
		if items_in_range[i] == null || items_in_range[i].name != "GroundToolArea":
			pass
		elif item_near == null:
			item_near = items_in_range[i]
			near_item_index = i
		else:
			if items_in_range[i].global_position.distance_to(self.global_position) < item_near.global_position.distance_to(self.global_position):
				item_near = items_in_range[i]
				near_item_index = i
	if items_in_range.size() != 0 && items_in_range[0] == null:
		items_in_range.remove_at(0)
	if items_in_range.size() == 0:
		item_available = false
		return
	if toolSlot.currentTool != "None":
		dropTool()
	#print(item_near)
		
	toolSlot.addTool(item_near.get_parent().name, item_near.get_parent().data, item_near.get_parent().durability)
	
	#Call func to check tutorial progress
	if toolSlot.currentTool == "Hoe":
		tutorial_manager.check_tut_progress("Pick Up Hoe")
	if toolSlot.currentTool == "Trap":
		tutorial_manager.check_tut_progress("Pick Up Trap")
	#toolSlot.currentTool = item_near.get_parent().name
	#toolSlot.updateTool()
	items_in_range.erase(item_near)
	item_near.get_parent().queue_free()
	item_near = null

func sell_item():
	var sellSlotNum
	match inventory.curHotbarSlot:
		1:
			sellSlotNum = 1
		2:
			sellSlotNum = 2
		3:
			sellSlotNum = 3
		4:
			sellSlotNum = 4
	var sellSlot = inventory.find_child("Slot" + str(sellSlotNum))
	if sellSlot.item != null:
		if str(ItemData.item_data[sellSlot.item.item_name]["ItemCategory"]) == "Resource":
			money += int(sellSlot.item.item_quantity) * int(ItemData.item_data[sellSlot.item.item_name]["Value"])
			sellSlot.deleteItem()
			PlayerInventory.inventory.erase(sellSlotNum - 1)
			audio_manager.play_sell_sound()
	
func plant_seed():
	var near_soil_index : int
	for i in soils_in_range.size():
		if soils_in_range[i] == null:
			pass
		elif soil_near == null && !soils_in_range[i].soil.occupied:
			soil_near = soils_in_range[i]
			near_soil_index = i
		elif soil_near != null:
			if soils_in_range[i].soil.global_position.distance_to(self.global_position) < soil_near.soil.global_position.distance_to(self.global_position) && !soils_in_range[i].soil.occupied:
				soil_near = soils_in_range[i]
				near_soil_index = i
	if soils_in_range.size() != 0 && soils_in_range[0] == null:
		soils_in_range.remove_at(0)
	if soils_in_range.size() == 0:
		soil_available = false
		return
	if soil_near == null:
		return
	if !soil_near.soil.prepared:
		if inventory.toolSlot.currentTool == "Hoe":
			#call to tutorial function
			tutorial_manager.check_tut_progress("Use Hoe")
			print("Holding a hoe")
			soil_near.soil.togglePrepared()
		return
	elif inventory.toolSlot.currentTool == "Hoe":
		return
	soil_near.soil.createPlant(inventory.hotbarSlots[inventory.curHotbarSlot-1].item.item_name)
	tutorial_manager.check_tut_progress("Plant Seed")
	soil_near = null
	removeOneItem(inventory.curHotbarSlot)
	

func interact_with_plant():
	var near_soil_index : int
	for i in soils_in_range.size():
		if soils_in_range[i] == null:
			pass
		elif soils_in_range[i].soil.occupied:
			if soil_near == null:
				soil_near = soils_in_range[i]
				near_soil_index = i
			else:
				if soils_in_range[i].global_position.distance_to(self.global_position) < soil_near.global_position.distance_to(self.global_position):
					soil_near = soils_in_range[i]
					near_soil_index = i
	if soils_in_range.size() != 0 && soils_in_range[0] == null:
		soils_in_range.remove_at(0)
	if soils_in_range.size() == 0:
		soil_available = false
		return
	if soil_near != null:
		var plant = soil_near.soil.plant
		if plant.mature && inventory.toolSlot.currentTool == "Glove":
			plant.harvest()
			plant = null
			return
		if plant.taskActive:
			if plant.taskTool == inventory.toolSlot.currentTool:
				if plant.taskTool == "Glove":
					createVine(plant)
					pullingVine = true
					audio_manager.play_weeding_sound()
					#call tutorial function
					tutorial_manager.check_tut_progress("Pick Up Gloves")
				elif plant.taskTool != "Bucket":
					plant.completeTask()
				if plant.taskTool == "Bucket":
					if inventory.toolSlot.data[2] >= inventory.toolSlot.data[3]:
						audio_manager.play_water_sound()
						plant.completeTask()
						inventory.toolSlot.data[2] -= inventory.toolSlot.data[3]
						#call tutorial function
						tutorial_manager.check_tut_progress("Pick Up Water Can")
			elif inventory.toolSlot.currentTool == "None":
				if str(ItemData.item_data[inventory.hotbarSlots[inventory.curHotbarSlot - 1].item.item_name]) == "Fertilizer":
					plant.completeTask()
					removeOneItem(inventory.curHotbarSlot)
				

func removeOneItem(slotNum):
	var seedSlotNum
	match slotNum:
		1:
			seedSlotNum = 1
		2:
			seedSlotNum = 2
		3:
			seedSlotNum = 3
		4:
			seedSlotNum = 4
	var seedSlot = inventory.find_child("Slot" + str(seedSlotNum))
	if seedSlot.item.item_quantity > 1:
		seedSlot.pickOneFromSlot()
		PlayerInventory.inventory[seedSlotNum - 1][1] -= 1
	else:
		seedSlot.deleteItem()
		PlayerInventory.inventory.erase(seedSlotNum - 1)

func dropTool():
	audio_manager.play_drop_sound()
	var newGroundTool = groundTool.instantiate()
	
	newGroundTool.toolType = toolSlot.currentTool
	newGroundTool.name = toolSlot.currentTool
	find_parent("World").add_child(newGroundTool)
	newGroundTool.global_position = Vector3(self.global_position.x, 0.3, self.global_position.z)
	newGroundTool.updateData(toolSlot.data, toolSlot.durability)
	toolSlot.removeTool()
	
	#call tutorial function
	tutorial_manager.check_tut_progress("Drop Hoe")
	
	if toolSlot.currentTool == "Trap":
		tutorial_manager.check_tut_progress("Place Trap")
	#toolSlot.currentTool = "None"

func dropTool_fromShop(_name : String, _position : Vector3): # ONLY use with shop script
	audio_manager.play_drop_sound()
	var newGroundTool = groundTool.instantiate()
	
	newGroundTool.name = _name
	find_parent("World").add_child(newGroundTool)
	newGroundTool.global_position = Vector3(_position.x, 0.3, _position.z)
	#newGroundTool.updateData(toolSlot.data, toolSlot.durability)
	#toolSlot.removeTool()


func _on_player_area_area_entered(area: Area3D) -> void:
	pass
	

func _on_player_area_area_exited(area: Area3D) -> void:
	pass
	

func _on_interact_area_area_entered(area: Area3D) -> void:
	if area.name == "SoilArea":
		soils_in_range.append(area)
		soil_available = true
	elif area.name == "SellArea":
		can_sell = true
	elif area.name == "ShopArea":
		can_shop = true
	elif area.name == "WaterWellArea":
		can_fill_bucket = true
	elif area.name == "GroundToolArea":
		if items_in_range.size() != 0:
			if !items_in_range.has(area):
				items_in_range.append(area)
		else:
			items_in_range.append(area)
		item_available = true


func _on_interact_area_area_exited(area: Area3D) -> void:
	if area.name == "SoilArea" && soils_in_range != null:
		soils_in_range.erase(area)
		if soils_in_range.size() == 0:
			soil_available = false
			soil_near = null
	elif area.name == "SellArea":
		can_sell = false
	elif area.name == "ShopArea":
		can_shop = false
	elif area.name == "WaterWellArea":
		can_fill_bucket = false
	elif area.name == "GroundToolArea":
		for addedAreas in items_in_range:
			if area == addedAreas:
				items_in_range.erase(addedAreas)
		if items_in_range.size() == 0:
			item_available = false
			item_near = null


func talk_to_townsfolk():
	if !PlayerInventory.interface_open:
		nearby_townsfolk.interact()
		PlayerInventory.interface_open = true
	pass

#----------------------------DUMMY FUNCTION FOR RECOGNIZING PLAYER
func player():
	pass
