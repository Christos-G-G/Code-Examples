extends Node2D

const type = 3
var tileSprite
var active = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tileSprite = get_parent().find_child("Sprite2D")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	active = !active
	if active:
		tileSprite.modulate = Color("b55945")
		var areas = $Area2D.get_overlapping_areas()
		if $Area2D.has_overlapping_areas():
			areas[0].find_parent("Level").find_child("MovementController").loseCondition(2)
	else:
		tileSprite.modulate = Color(1, 1, 1)
