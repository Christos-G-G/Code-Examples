extends Control


@export var controlNode : Control
var popup
var captcha
var downloadWindow
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	popup = load("res://popup.tscn")
	captcha = load("res://captcha.tscn")
	downloadWindow = load("res://download_bar.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible == true && $"..".firstDownloadOpen:
		controlNode.firstDownloadOpen = false
		spawnPopups()
		
	pass
	
func spawnPopups():
	for popupNum in 15:
		var newPopup = popup.instantiate()
		add_child(newPopup)
		var sizeX = get_viewport().get_visible_rect().size.x
		var sizeY = get_viewport().get_visible_rect().size.y
		newPopup.global_position.x = randi_range(0 + sizeX / 9.0, sizeX - sizeX / 4.5)
		newPopup.global_position.y = randi_range(0 + sizeY / 4.5, sizeY - sizeY / 4.5)
		await get_tree().create_timer(0.1).timeout
		
	pass
	

func _on_download_button_pressed() -> void:
	find_parent("Control").playClick()
	var newCaptcha = captcha.instantiate()
	add_child(newCaptcha)
	pass # Replace with function body.
	
	
func finishCaptcha():
	var newDownloadWindow = downloadWindow.instantiate()
	add_child(newDownloadWindow)
