extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	find_parent("Control").playClick()
	find_parent("Control").openTab()
	queue_free()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	$Button.show()
	pass # Replace with function body.
