extends Node3D

@export var hound_prefab : PackedScene
@export var monster_prefab : PackedScene # for later
@export var monster_particles : PackedScene

@onready var audio_manager = $"/root/World/AudioManager"
@onready var player = $"/root/World/Player"

var player_detected:= false
var detection_range : float = 10.0

var random = RandomNumberGenerator.new()
var canSpawn = true
	

func _on_night_start() -> void:
	pass
	#spawn_hound()

func spawn_hound() -> void:
	
	var hound = hound_prefab.instantiate()
	get_parent().add_child.call_deferred(hound) # should be the World node
	
	hound.position = global_position + Vector3(0, 5, 0)

	audio_manager.play_monster_breathing()
	
	var monster_vfx = monster_particles.instantiate()
	hound.add_child(monster_vfx)
	monster_vfx.position = Vector3(0, 0, 0)
	monster_vfx.emitting = true

func _process(_delta: float) -> void:
	
	if !Global.isDay && Global.currentTime % 60 == 0 && canSpawn:
	#if Global.currentTime % 60 == 0 && canSpawn:
		canSpawn = false
		var chance = random.randi_range(10, 100)
		if chance > 50:
			spawn_hound()
		$SpawnCooldown.start()
		
	spot_player()


func _on_spawn_cooldown_timeout() -> void:
	canSpawn = true

func spot_player():
	if player != null:
		var distance = global_position.distance_to(player.global_position)
	
		if distance < detection_range:
			if !player_detected:
				player_detected = true
				audio_manager.play_monster_chase()
				audio_manager.play_monster_laugh()
			
		else:
			if player_detected:
				player_detected = false
				audio_manager.stop_monster_sounds()
