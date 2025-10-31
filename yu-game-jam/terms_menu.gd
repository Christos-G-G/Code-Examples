extends Control

var scrollValue
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scrollValue = $RichTextLabel.get_v_scroll_bar().value
	if scrollValue >= 2887:
		if !$CheckButton.visible:
			$CheckButton.show()
			$Label.show()
	if $CheckButton.button_pressed:
		$Label2.show()
		$TextEdit.show()
		$Button.show()
	pass
