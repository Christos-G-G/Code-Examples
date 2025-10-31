extends Control

var value = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = value
	if value >= 100:
		find_parent("Control").finishDownloadSequence()
		queue_free()
	pass


func _on_timer_timeout() -> void:
	value += 0.1
	pass # Replace with function body.


func _on_button_pressed() -> void:
	find_parent("Control").playClick()
	value += 2
	pass # Replace with function body.
