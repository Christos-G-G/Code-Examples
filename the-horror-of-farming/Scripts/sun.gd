extends DirectionalLight3D

@onready var animation_player = $AnimationPlayer
@onready var ambient_timer = $Timer # Timer for random ambient sounds


func _ready() -> void:
	animation_player.play("day_night_cycle")
	animation_player.seek(80.0)
	#cycle()

func _process(_delta: float) -> void:
	pass
	#print(str(animation_player.get_current_animation_position()) + " vs " + str(Global.currentTime / 2.0))
	#print("Difference: " + str(animation_player.get_current_animation_position() - float(Global.currentTime / 2.0)))


func _on_ambient_timer_timeout() -> void:
	
	ambient_timer.wait_time = randf_range(10.0, 30.0)
	ambient_timer.start()
#var _day_length := DayNight.day_length
#var _night_length := DayNight.night_length
#var _total_cycle_length = _day_length + _night_length

#var _dawn_duration = 90
#var _day_duration = 750
#var _dusk_duration = 90
#var _night_duration = 510

#@export_group("Colours")
#@export var dawn_colour := Color("e88e3e")
#@export var day_colour := Color.WHITE
#@export var dusk_colour := Color("e88e3e")
#@export var night_colour := Color("263f9e")

#var tw_night_to_dawn_colour : Tween
#var tw_day_to_dusk_colour : Tween

#func cycle() -> void:
#	print(_total_cycle_length)
#	
#	tw_night_to_dawn_colour = get_tree().create_tween()
#	tw_night_to_dawn_colour.set_trans(Tween.TRANS_CUBIC)
#	tw_night_to_dawn_colour.set_ease(Tween.EASE_IN_OUT)
#	tw_night_to_dawn_colour.tween_property(self, "light_color", dawn_colour, _dawn_duration)
#	
#	tw_night_to_dawn_colour.chain().tween_property(self, "light_color", day_colour, _dawn_duration)
#	
#	tw_day_to_dusk_colour = get_tree().create_tween()
#	tw_day_to_dusk_colour.set_trans(Tween.TRANS_CUBIC)
#	tw_day_to_dusk_colour.set_ease(Tween.EASE_IN_OUT)
#	tw_day_to_dusk_colour.tween_property( \
#		self,			\
#		"light_color",	\
#		dusk_colour,	\
#		_dusk_duration	\
#	)
#	
#	tw_day_to_dusk_colour.chain().tween_property( \
#		self,			\
#		"light_color",	\
#		night_colour,	\
#		_dusk_duration	\
#	)
