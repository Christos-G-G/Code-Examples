extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.global_position.distance_to(get_global_mouse_position()) <= 40:
		self.global_position.x += 10
	pass
