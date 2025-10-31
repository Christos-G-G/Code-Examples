extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if Input.is_action_just_pressed("Enter"):
		if $TextEdit.text == "horse.go":
			find_parent("Control").backToGamePage()
			queue_free()
	pass


func _on_spawn_clippy_timeout() -> void:
	$Clippy.show()
	$Clippy/Line1.play()
	pass # Replace with function body.


func _on_yes_1_pressed() -> void:
	find_parent("Control").playClick()
	$Clippy/Label.hide()
	$Clippy/Yes1.hide()
	$Clippy/Yes2.hide()
	await get_tree().create_timer(0.4).timeout
	$Clippy/Label.text = "."
	$Clippy/Label.show()
	await get_tree().create_timer(0.4).timeout
	for i in 4:
		$Clippy/Label.text += "."
		await get_tree().create_timer(0.4).timeout
	$Clippy/Label.hide()
	$Clippy/Label2.show()
	$Clippy/Line2.play()
