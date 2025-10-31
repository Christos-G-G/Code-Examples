extends Control

@onready var _label : Label  = $ScrollContainer/Label

func set_text(text : String) -> void:
	_label.text = text

func _on_button_pressed() -> void:
	queue_free()
