extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $DownloadBar/ProgressBar.value >= 100:
		$DownloadBar/OpenButton.show()
	pass


func _on_yes_button_pressed() -> void:
	find_parent("Control").playClick()
	$FirstMenu.hide()
	$TermsMenu.show()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	find_parent("Control").playClick()
	if $TermsMenu/TextEdit.text.to_upper() == "HORSE":
		$TermsMenu.hide()
		$DownloadBar.show()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	if $DownloadBar.visible:
		$DownloadBar/ProgressBar.value += 1
	pass # Replace with function body.


func _on_open_button_pressed() -> void:
	find_parent("Control").playClick()
	find_parent("Control").openTerminal()
	queue_free()
	pass # Replace with function body.
