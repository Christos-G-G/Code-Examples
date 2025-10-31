extends Panel

var currentTool : String = "None"
var item : String
var data : Array
var durability : int

@export var waterGraphic : ProgressBar
@export var toolTexture : TextureRect


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	item = currentTool
	if currentTool == "None" && toolTexture.texture != null:
		toolTexture.texture = null
	if currentTool == "Bucket":
		waterGraphic.show()
		waterGraphic.value = data[2]
	else:
		waterGraphic.hide()

func addTool(toolName, toolData, toolDurability):
	currentTool = toolName
	data = toolData.duplicate()
	durability = toolDurability
	updateTool()
	pass
	
func updateTool():
	if currentTool.contains("Trap"):
		toolTexture.texture = load("res://Art/character/" + "Trap" + ".png")
	else:
		toolTexture.texture = load("res://Art/character/" + str(currentTool) + ".png")
		

func removeTool():
	currentTool = "None"
	pass
	
