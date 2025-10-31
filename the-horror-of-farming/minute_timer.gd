extends Timer

var minuteCount = 0
var lightAngles = [-10, -160]
var active = false

@onready var audio_manager = $/root/World/AudioManager
@onready var ui_layer = get_node("/root/World/UI_Layer")
@onready var clock_hand = $/root/World/Control/ClockDisplay/ClockHand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# for debugging:
	#await get_tree().create_timer(1).timeout
	#ui_layer.add_news()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_clock_hand()
#	$"../Control/TimeDisplay".text = str(Global.hour) + ":" + str(minuteCount)
	#$"../Control/TimeDisplay".text = "%d:%02d" % [Global.hour, minuteCount]
	#$"../Control/TimeDisplay".text += "\nDaytime: " + str(Global.isDay)
	#$"../Control/TimeDisplay".text += "\nDay " + str(Global.curDay)


func update_clock_hand():
	var total_day_time = DayNight.day_length + DayNight.night_length
	var time_ratio = Global.currentTime / total_day_time
	var total_rotation = (time_ratio * 360.0) - 180
	
	clock_hand.rotation_degrees = total_rotation
	
func _on_timeout() -> void:
	Global.timeOfDay.emit(Global.currentTime, Global.isDay)
	
	if Global.currentTime < Global.maxTime:
		Global.currentTime += 1
	else:
		Global.currentTime = 1
	minuteCount += 1
	if minuteCount == 60:
		Global.hour += 1
		if Global.hour == 24:
			Global.curDay += 1
			Global.hour = 0
		minuteCount = 0

	if Global.currentTime == 240:
		Global.isDay = true
		audio_manager.set_day()
		ui_layer.add_news()
	if Global.currentTime == 1200:
		Global.isDay = false
		audio_manager.set_night()
		
	#if minuteCount < 10:
		#print("Current time is " + str(Global.currentTime) + ", or " + str(Global.hour) + ":0" + str(Global.currentTime - (Global.hour) * 60))
	#else:
		#print("Current time is " + str(Global.currentTime) + ", or " + str(Global.hour) + ":" + str(Global.currentTime - (Global.hour) * 60))
	#print("It is Minute #" + str(minuteCount))
	pass # Replace with function body.
