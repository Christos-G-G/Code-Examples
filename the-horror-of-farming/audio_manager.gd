extends Node

@export var day_music: AudioStream
@export var night_music: AudioStream
@export var fade_timer: Timer

@export var button_sound: AudioStream
@export var open_menu_sound: AudioStream

@export var ambient_audio_sounds: Array[AudioStream]
@export var ambient_timer: Timer
@export var ambient_audio_player: AudioStreamPlayer

@export var planting_sound: AudioStream
@export var harvesting_sound: AudioStream
@export var hoeing_sound: AudioStream
@export var water_sound: AudioStream
@export var weeding_sound: AudioStream
@export var weedSnap_sound: AudioStream

@export var pick_up_sound: AudioStream
@export var drop_sound: AudioStream

@export var buy_sound: AudioStream
@export var sell_sound: AudioStream

@export var player_walking_sound: AudioStream

@export var monster_breathing_sound: AudioStream
@export var monster_laugh_sound: AudioStream
@export var monster_chase_sound: AudioStream


var fade_duration := 2.0
var fade_data = {}
var day_audio_player: AudioStreamPlayer
var night_audio_player: AudioStreamPlayer
var button_click_player: AudioStreamPlayer
var open_menu_player: AudioStreamPlayer
var pick_up_player: AudioStreamPlayer
var drop_player: AudioStreamPlayer
var walking_player: AudioStreamPlayer
var buy_player: AudioStreamPlayer
var sell_player: AudioStreamPlayer
var planting_player: AudioStreamPlayer
var harvesting_player: AudioStreamPlayer
var hoeing_player: AudioStreamPlayer
var water_player: AudioStreamPlayer
var weeding_player: AudioStreamPlayer
var monster_breath_player: AudioStreamPlayer
var monster_laugh_player: AudioStreamPlayer
var monster_chase_player: AudioStreamPlayer
var weedSnap_player: AudioStreamPlayer

func _ready():
	day_audio_player = $BG_Music/DayMusic
	night_audio_player = $BG_Music/NightMusic
	button_click_player = $UI_Sfx/ButtonClick
	open_menu_player = $UI_Sfx/OpenMenu
	pick_up_player = $Items_Sfx/PickUpItem
	drop_player = $Items_Sfx/DropItem
	walking_player = $Player_Sfx/Walking
	buy_player = $Shop_Sfx/Buy
	sell_player = $Shop_Sfx/Sell
	planting_player = $Farming_sfx/Planting
	harvesting_player = $Farming_sfx/Harvesting
	hoeing_player = $Farming_sfx/Hoeing
	water_player = $Farming_sfx/WaterPlants
	weeding_player = $Farming_sfx/PullVines
	monster_breath_player = $Monster_Sfx/MonsterBreathing
	monster_chase_player = $Monster_Sfx/MonsterChase
	monster_laugh_player = $Monster_Sfx/MonsterLaugh
	weedSnap_player = $Farming_sfx/VineSnap
	
	fade_timer.wait_time = 0.1
	fade_timer.connect("timeout", Callable(self, "_on_fade_step"))
	
	ambient_timer.connect("timeout", Callable(self, "_on_ambient_timer_timeout"))
	ambient_audio_player.process_mode = Node.PROCESS_MODE_ALWAYS
	ambient_timer.one_shot = true
	
	day_audio_player.volume_db = -50
	night_audio_player.volume_db = 0
	
	
	if day_audio_player == null or night_audio_player == null:
		print("Error: One or both AudioStreamPlayer nodes not found")
	else:
		if (Global.isDay == true):
			set_day()
		else:
			set_night()
			
	
func set_day():
	night_audio_player.volume_db = 0
	day_audio_player.volume_db = -80
	day_audio_player.play()
	start_fade(day_audio_player, night_audio_player)
	
	ambient_timer.stop()

func set_night():
	day_audio_player.volume_db = 0
	night_audio_player.volume_db = -80
	night_audio_player.play()
	start_fade(night_audio_player, day_audio_player)
	
	start_ambient_sounds()
	
func start_ambient_sounds():
	if ambient_audio_sounds.is_empty():
		return
		
	play_random_ambient_sound()
	
func play_random_ambient_sound():
	if ambient_audio_sounds.is_empty():
		return
		
	ambient_audio_player.stream = ambient_audio_sounds[randi() % ambient_audio_sounds.size()]
	ambient_audio_player.play()
	
	ambient_timer.start(randf_range(10, 20))
	
func _on_ambient_timer_timeout():
	play_random_ambient_sound()
	
func start_fade(fade_in_player: AudioStreamPlayer, fade_out_player: AudioStreamPlayer):
	fade_timer.start()
	fade_data = {"fade_in": fade_in_player, "fade_out": fade_out_player, "elapsed": 0}
	
func _on_fade_step():
	if fade_data:
		var fade_in = fade_data["fade_in"]
		var fade_out = fade_data["fade_out"]
		var elapsed = fade_data["elapsed"]
		
		elapsed += fade_timer.wait_time
		var t = elapsed / fade_duration
		
		fade_in.volume_db = lerp(-80, 0, t)
		fade_out.volume_db = lerp(0, -80, t)
		
		fade_data["elapsed"] = elapsed
		
		if elapsed >= fade_duration:
			fade_timer.stop()
			fade_out.stop()

func play_open_menu_sound():
	open_menu_player.play()
	open_menu_player.stream = open_menu_sound
	open_menu_player.play()
	
func button_click_sound():
	button_click_player.stop()
	button_click_player.stream = button_sound
	button_click_player.play()

func play_pickUp_sound():
	pick_up_player.stream = pick_up_sound
	pick_up_player.play()
	
func play_drop_sound():
	drop_player.stream = drop_sound
	drop_player.play()

func player_walking_sfx():
	walking_player.stream = player_walking_sound
	walking_player.play()

func stop_walking_sfx():
	if walking_player.playing:
		walking_player.stop()
	
func play_monster_breathing():
	monster_breath_player.stream = monster_breathing_sound
	monster_breath_player.play()
	
func play_monster_chase():
	monster_chase_player.stream = monster_chase_sound
	monster_chase_player.play()
	
func play_monster_laugh():
	monster_laugh_player.stream = monster_laugh_sound
	monster_laugh_player.play()
	
func stop_monster_sound():
	monster_breath_player.stop()
	monster_chase_player.stop()
	monster_laugh_player.stop()
	
func play_buy_sound():
	buy_player.stream = buy_sound
	buy_player.play()
	
func play_sell_sound():
	sell_player.stream = sell_sound
	sell_player.play()
	
func play_planting_sound():
	planting_player.stream = planting_sound
	planting_player.play()
	
func play_harvesting_sound():
	harvesting_player.stream = harvesting_sound
	harvesting_player.play()
	
func play_hoeing_sound():
	hoeing_player.stream = hoeing_sound
	hoeing_player.play()

func play_water_sound():
	water_player.stream = water_sound
	water_player.play()
	
func play_weeding_sound():
	weeding_player.stream = weeding_sound
	weeding_player.play()
	
func play_snap_sound():
	weedSnap_player.stream = weedSnap_sound
	weedSnap_player.play()
