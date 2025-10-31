extends Button

func _ready() -> void:
	icon = load("res://Art/Popup" + str(randi_range(1, 11)) + ".png")
	
func _on_pressed() -> void:
	find_parent("Control").playClick()
	self.queue_free()
