extends CharacterBody3D
class_name Hound
@export var hitboxArea : Area3D

func _on_day_start() -> void:
	# disappear
	var connections = get_incoming_connections()
	
	for _signal in connections:
		_signal.get("signal").disconnect(_on_day_start)
	
	queue_free()
	pass

#region health

@export var max_health := 100
var health := max_health

func add_health(_amount : int) -> void:
	pass

func remove_health(amount : int) -> void:
	if amount <= 0: return
	
	health -= amount
	
	if health <= 0:
		print("Hound %s died" % name)

#endregion

#region movement

@export var max_speed := 10

@onready var starting_pos = global_position

enum Direction {
	UP_LEFT, UP, UP_RIGHT, 
	RIGHT,
	DOWN_RIGHT, DOWN, DOWN_LEFT,
	LEFT,
	NONE
}
var current_direction = Direction.NONE

enum MoveState {
	IDLE,
	TAKE,
	RUN
}
var current_move_state = MoveState.IDLE

func end_idle_state() -> void:
	var rng = RandomNumberGenerator.new()
	var time = rng.randf_range(5, 10)
	
	await get_tree().create_timer(time).timeout
	
	current_move_state = MoveState.TAKE
	destination = target_soil.global_position

var destination

func move_to_destination(delete_destination := false) -> void:
	if not destination:
		return
	
	var true_destination := Vector3.ZERO
	true_destination.x = destination.x
	true_destination.y = position.y
	true_destination.z = destination.z
	
	velocity = global_position.direction_to(true_destination) * max_speed
	move_and_slide()
	
	if not delete_destination:
		return
	
	if global_position == true_destination:
		destination = null

func choose_random_nearby_destination() -> void:
	var rng := RandomNumberGenerator.new()
	
	var new_destination := global_position
	new_destination.x += rng.randf_range(-30, 30)
	new_destination.z += rng.randf_range(-30, 30)
	
	current_move_state = MoveState.IDLE
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(global_position, new_destination)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	
	if not result:
		destination = new_destination
		return
	
	new_destination = result.position
	new_destination.move_toward(global_position, 7)
	
	destination = new_destination

#endregion

#region detection

@onready var soils : Array[Node] = get_tree().get_nodes_in_group("Soil")
var target_soil : Node

func find_crop() -> void:
	for soil in soils:
		if "occupied" in soil \
		and soil.occupied:
			target_soil = soil
			print("found target in %s" % soil)
			destination = soil.global_position
			return
	queue_free()

@export var crop_take_distance = 10

func take_crop() -> void:
	var distance_to_crop = global_position.distance_to(target_soil.global_position)
	if distance_to_crop > crop_take_distance:
		return
	
	print(target_soil)
	if target_soil.plant != null:
		target_soil.plant.wither()
	
	print("took crop from target")
	
	destination = starting_pos
	
	current_move_state = MoveState.RUN

#endregion

func _ready() -> void:
	find_crop()
	end_idle_state()

func _process(_delta: float) -> void:
	update_animation()
	
	if current_move_state != MoveState.TAKE:
		move_to_destination(true)
		
		if destination == null:
			choose_random_nearby_destination()
	else:
		move_to_destination()
	
	if target_soil:
		take_crop()
	if global_position.distance_to(starting_pos) < crop_take_distance && destination == starting_pos:
		queue_free()

var item_near
var item_available := false

#region damage
var is_taking_damage := false
var damage_per_sec := 10

#func _on_hitbox_area_area_entered(area: Area3D) -> void:
	#print("Entered area " + str(area))
	#if area.name == "LanternLight" && area.visible:
		#queue_free()
	#pass # Replace with function body.

func _on_hitbox_area_area_entered(area: Area3D) -> void:
	print("Entered area " + str(area))
	if area.name == "LanternLight" && area.visible:
		is_taking_damage = true
		damage_self()
		

func _on_hitbox_area_area_exited(area: Area3D) -> void:
	print("Exited area " + str(area))
	if area.name == "LanternLight" && area.visible:
		is_taking_damage = false

func damage_self() -> void:
	remove_health(damage_per_sec)
	await get_tree().create_timer(1).timeout
	
	if health <= 0:
		queue_free()
	if not is_taking_damage:
		return
	
	damage_self()

#endregion

#region animation

@onready var sprite : AnimatedSprite3D = $AnimatedSprite3D

func update_animation() -> void:
	if current_move_state == MoveState.IDLE:
		if sprite.is_playing() and sprite.animation == "idle":
			return
		sprite.play("idle")
	else:
		if sprite.is_playing() and sprite.animation == "walk":
			return
		sprite.play("walk")

#endregion
