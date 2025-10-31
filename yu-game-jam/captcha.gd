extends Control


var eS = 0
var emptyNode
var tempTexture
var tempValue
var layout = [9, 1, 2, 5, 6, 3, 4, 7, 8]
var button1
var button2
var button3
var button4
var button5
var button6
var button7
var button8
var button9
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button1 = $GridContainer/Button1
	button2 = $GridContainer/Button2
	button3 = $GridContainer/Button3
	button4 = $GridContainer/Button4
	button5 = $GridContainer/Button5
	button6 = $GridContainer/Button6
	button7 = $GridContainer/Button7
	button8 = $GridContainer/Button8
	button9 = $GridContainer/Button9
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	emptyNode = $GridContainer.get_child(eS)
	if layout == [1, 2, 3, 4, 5, 6, 7, 8, 9]:
		find_parent("DownloadPage").finishCaptcha()
		queue_free()
	pass


func _on_button_pressed() -> void:
	pass # Replace with function body.
	if eS == 1 || eS == 3:
		tempTexture = button1.get_button_icon()
		button1.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[0]
		layout[0] = layout[eS]
		layout[eS] = tempValue
		eS = 0
		pass


func _on_button_2_pressed() -> void:
	if eS == 0 || eS == 2 || eS == 4:
		tempTexture = button2.get_button_icon()
		button2.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[1]
		layout[1] = layout[eS]
		layout[eS] = tempValue
		eS = 1
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	if eS == 1 || eS == 5:
		tempTexture = button3.get_button_icon()
		button3.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[2]
		layout[2] = layout[eS]
		layout[eS] = tempValue
		eS = 2
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	if eS == 0 || eS == 4 || eS == 6:
		tempTexture = button4.get_button_icon()
		button4.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[3]
		layout[3] = layout[eS]
		layout[eS] = tempValue
		eS = 3
	pass # Replace with function body.


func _on_button_5_pressed() -> void:
	if eS == 1 || eS == 3 || eS == 5 || eS == 7:
		tempTexture = button5.get_button_icon()
		button5.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[4]
		layout[4] = layout[eS]
		layout[eS] = tempValue
		eS = 4
	pass # Replace with function body.


func _on_button_6_pressed() -> void:
	if eS == 2 || eS == 4 || eS == 8:
		tempTexture = button6.get_button_icon()
		button6.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[5]
		layout[5] = layout[eS]
		layout[eS] = tempValue
		eS = 5
	pass # Replace with function body.


func _on_button_7_pressed() -> void:
	if eS == 3 || eS == 7:
		tempTexture = button7.get_button_icon()
		button7.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[6]
		layout[6] = layout[eS]
		layout[eS] = tempValue
		eS = 6
	pass # Replace with function body.


func _on_button_8_pressed() -> void:
	if eS == 6 || eS == 8 || eS == 4:
		tempTexture = button8.get_button_icon()
		button8.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[7]
		layout[7] = layout[eS]
		layout[eS] = tempValue
		eS = 7
	pass # Replace with function body.


func _on_button_9_pressed() -> void:
	if eS == 7 || eS == 5:
		tempTexture = button9.get_button_icon()
		button9.set_button_icon(emptyNode.get_button_icon())
		emptyNode.set_button_icon(tempTexture)
		tempValue = layout[8]
		layout[8] = layout[eS]
		layout[eS] = tempValue
		eS = 8
	pass # Replace with function body.
	
