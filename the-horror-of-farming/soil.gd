extends Node3D

@onready var plantTemplate = load("res://plant.tscn")
@export var occupied : bool = false
@export var prepared : bool = false
@onready var audio_manager = $"/root/World/AudioManager"

var plant

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func togglePrepared():
	if prepared:
		#$Sprite3D.modulate = Color(1, 0.5, 1, 1)
		$Sprite3D.texture = load("res://Art/Environment/Soil_Unplantable.PNG")
		$PlantHarvestFX.playEffect()
	else:
		#$Sprite3D.modulate = Color(1, 0.475, 0.388, 1)
		$Sprite3D.texture = load("res://Art/Environment/Soil_Regular.PNG")
	prepared = !prepared
	audio_manager.play_hoeing_sound()
	
#Information is held in the seed item, and passed here when planted
#PlantType - The name (eg. Turnip)
#GrowTime - The maximum Grow Time (in game hours)
#TaskTimes - an Array of [Minimum time between tasks, Maximum time between tasks] in Seconds, starting when a new task is opened
#QualityScores - array of [Minimum quality score, Normal Quality Score, High quality score], where:
# Failing the minimum score # of tasks = plant immediately fails
# Reaching High Quality Score + 1 = plant immediately is harvested at high quality
# Otherwise if the grow period ends then you harvest it at whatever the highest quality score you reached is
#CareTypes - Boolean array for determining tasks [Watering, Weeding, Fertilizing]
#CareTimes - Boolean array for [DayCare, NightCare]
func createPlant(plantName):
	occupied = true
	var plantType = ItemData.item_data[plantName]["PlantType"]
	var growTime = ItemData.item_data[plantName]["MaxGrowTime"]
	var taskTimes = ItemData.item_data[plantName]["TaskTimes"]
	var qualityScores = ItemData.item_data[plantName]["QualityScores"]
	var careTypes = ItemData.item_data[plantName]["CareTypes"]
	var careTimes = ItemData.item_data[plantName]["CareTimes"]
	var myPlant = plantTemplate.instantiate()
	myPlant.construct(plantType, growTime, taskTimes, qualityScores, careTypes, careTimes)
	self.add_child(myPlant)
	plant = myPlant
	plant.soil = self
	
