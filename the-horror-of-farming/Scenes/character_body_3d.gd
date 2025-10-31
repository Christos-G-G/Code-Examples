extends CharacterBody3D
var maxHealth = 100
var health = 100

var speed = 20
var current_dir = "none"
var item_near

var item_available = false
var allowPickup = true

var in_interface = false

var input = Vector2.ZERO
var inventory
var toolSlot
var groundTool = load("res://Scenes/ground_tool.tscn")

func _ready():
	$SubViewport/AnimatedSprite2D
	pass
	
func _physics_process(delta):
	current_dir = find_direction()
	if find_child("Camera3D").get_child_count() > 2:
		pass
	else:
		player_actions(delta)
	if health <= 0:
		print("RESPAWNED!")
		self.position = Vector3(0, 0, 0)
		health = maxHealth
	
func player_actions(delta):
	input = get_input()
	
	if Input.is_action_just_pressed("Interact"):
		if item_available:
			pickup_item()
		elif townsfolk_in_range:
			talk_to_townsfolk()
			
	if Input.is_action_just_pressed("DropTool") && toolSlot.currentTool != "None":
		dropTool()

	if !find_parent("World").find_child("UI Layer").inventoryOpen:
		if input == Vector2.ZERO:
			velocity = Vector3(input.x, 0, input.y)
		else:
			velocity = Vector3(input.x * speed, 0, input.y * speed)
	
	###play_anim()
	move_and_slide()

#--------------------------MOVEMENT, ANIMATION, ROLLING
func get_input():
	input.x = int(Input.is_action_pressed("MoveRight")) - int(Input.is_action_pressed("MoveLeft"))
	input.y = int(Input.is_action_pressed("MoveDown")) - int(Input.is_action_pressed("MoveUp"))
	return input.normalized()

func find_direction():
	"""
	var direction = find_child("Camera").direction
	if (-157.5 <= direction && direction <= -112.5):
		return "up_left"
	elif (-112.5 <= direction && direction <= -67.5):
		return "up"
	elif (-67.5 <= direction && direction <= -22.5):
		return "up_right"
	elif (-22.5 <= direction && direction <= 22.5):
		return "right"
	elif (22.5 <= direction && direction <= 67.5):
		return "down_right"
	elif (67.5 <= direction && direction <= 112.5):
		return "down"
	elif (112.5 <= direction && direction <= 157.5):
		return "down_left"
	else:
		return "left"
	"""

func play_anim():
	var dir = current_dir
	var anim = $SubViewport/AnimatedSprite2D

	if dir == "up_left":
		anim.flip_h = true
		if input.x != 0 || input.y != 0:
			anim.play("back_diagonal_walk")
		else:
				anim.play("back_diagonal_idle")
	elif dir == "up":
		anim.flip_h = false
		if input.x != 0 || input.y != 0:
			anim.play("back_walk")
		else:
			anim.play("back_idle")
	elif dir == "up_right":
		anim.flip_h = false
		if input.x != 0 || input.y != 0:
			anim.play("back_diagonal_walk")
		else:
			anim.play("back_diagonal_idle")
	elif dir == "right":
		anim.flip_h = false
		if input.x != 0 || input.y != 0:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	elif dir == "down_right":
		anim.flip_h = false
		if input.x != 0 || input.y != 0:
			anim.play("front_diagonal_walk")
		else:
			anim.play("front_diagonal_idle")
	elif dir == "down":
		anim.flip_h = false
		if input.x != 0 || input.y != 0:
			anim.play("front_walk")
		else:
			anim.play("front_idle")
	elif dir == "down_left":
		anim.flip_h = true
		if input.x != 0 || input.y != 0:
			anim.play("front_diagonal_walk")
		else:
			anim.play("front_diagonal_idle")
	elif dir == "left":
		anim.flip_h = true
		if input.x != 0 || input.y != 0:
			anim.play("side_walk")
		else:
			anim.play("side_idle")

#------------------------INTERACTION, ITEM AND TOWNSFOLK
var items_in_range
var townsfolk_in_range
var nearby_townsfolk

func pickup_item():
	var near_item_index
	for i in items_in_range.size():
		if items_in_range[i] == null:
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
	toolSlot.currentTool = item_near.get_parent().name
	toolSlot.updateTool()
	items_in_range.erase(item_near)
	item_near.get_parent().queue_free()
	item_near = null
	
func dropTool():
	var newGroundTool = groundTool.instantiate()
	newGroundTool.toolType = toolSlot.currentTool
	newGroundTool.name = toolSlot.currentTool
	find_parent("World").add_child(newGroundTool)
	newGroundTool.global_position = Vector3(self.global_position.x, 0.3, self.global_position.z)
	toolSlot.currentTool = "None"
	
func _on_player_area_area_entered(area: Area3D) -> void:
	if area.name == "GroundToolArea":
		print("AREA ENTERED: " + str(area.get_parent().name))
		items_in_range = $PlayerArea.get_overlapping_areas()
		item_available = true

func _on_player_area_area_exited(area: Area3D) -> void:
	if area.name == "GroundToolArea":
		print("AREA LEFT: " + str(area.get_parent().name))
		items_in_range = $PlayerArea.get_overlapping_areas()
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
