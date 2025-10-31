extends Sprite3D

var toolType
var data
var durability

@export var light : SpotLight3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if name.contains("Trap"):
		texture = load("res://Art/character/Trap_Open.png")
	else:
		texture = load("res://Art/character/" + name + ".png")
	
	if name.contains("Trap"):
		toolType = "Trap"
	else:
		toolType = name
	
	if toolType == "Lantern":
		light.visible = true
		$LanternLight.hide()
	else:
		light.visible = false
		$LanternLight.show()
	
	if toolType.contains("Trap"):
		print("kept trap")
		toolType = "Trap"
	else:
		$TrapArea.queue_free()
		print("deleted trap")
	
	match toolType:
		"Lantern":
			#Data = [Tier, Light Angle]
			data = [1, 35]
			durability = 100
		"Glove":
			#Data = [Tier]
			data = [1]
			durability = 100
		"Bucket":
			#Data = [Tier, MaxWater, CurrentWater, WaterCost]
			data = [1, 100, 100, 20]
			durability = 100
		"Hoe":
			#Data = [Tier, Reach]
			data = [1, 1]
			durability = 100
		"Trap":
			#Data = [Tier]
			data = [1]
			durability = 100

func updateData(newData, newDurability):
	data = null
	data = newData.duplicate()
	durability = newDurability

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
