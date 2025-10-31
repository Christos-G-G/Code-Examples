extends Sprite2D

var active = false
var direction = 0
# Called when the node enters the scene tree for the first time.
func eye():
	pass

func _on_timer_timeout() -> void:
	active = !active
	match direction:
		1:
			pass
		2:	
			if active:
				texture = load("res://Art/Eye_2.PNG")
			else:
				texture = load("res://Art/Eye_2.2.PNG")
		3:
			if active:
				texture = load("res://Art/Eye_1.PNG")
			else:
				texture = load("res://Art/Eye_1.2.PNG")
		4:
			pass
	pass # Replace with function body.
