extends Node
class_name DayNight

signal day_start
signal night_start

var sensitive_objects

var current_state = CurrentState.DAY
enum CurrentState {DAY, NIGHT}

static var day_length : float = 960.0
static var night_length : float = 480.0



func _ready():
	sensitive_objects = get_tree().get_nodes_in_group("DayNightSensitive")
	
	for object in sensitive_objects:
		if object.has_method("_on_day_start"):
			day_start.connect(object._on_day_start)
			
		if object.has_method("_on_night_start"):
			night_start.connect(object._on_night_start)
	
	$"Day Length".wait_time = day_length
	$"Night Length".wait_time = night_length
	
	if current_state == CurrentState.DAY:
		$"Day Length".start()
		day_start.emit()
	else:
		$"Night Length".start()
		night_start.emit()

func _on_day_length_timeout() -> void:
	current_state = CurrentState.NIGHT
	night_start.emit()
	$"Night Length".start()
	

func _on_night_length_timeout() -> void:
	current_state = CurrentState.DAY
	day_start.emit()
	$"Day Length".start()
	

		
