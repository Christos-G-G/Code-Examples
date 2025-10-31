extends Node2D

var startingPosition
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startingPosition = global_position.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= 1
	if global_position.x <= startingPosition + 25:
		queue_free()
	pass
