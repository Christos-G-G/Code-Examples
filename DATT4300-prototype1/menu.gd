extends Node2D

var levelScene = preload("res://level.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$PlayBase.hide()
	self.replace_by(levelScene)
	pass # Replace with function body.
