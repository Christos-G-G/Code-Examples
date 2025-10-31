extends Node3D

@export var devInfo : Label3D
@export var plantTexture : Sprite3D
@onready var audio_manager = $"/root/World/AudioManager"
var soil
var plantType
var maxGrowTime
#Min, Max
var taskTimes = [0, 0]
#Low, Standard, High
var qualityScores = [0, 0, 0]
#Watering, Weeding, Fertilizer
var careTypes = [false, false, false]
#Day, Night
var careTimes = [false, false]

var random = RandomNumberGenerator.new()
var nextTaskTime
var previousTaskTime = 0
var curGrowTime = 0
var taskActive = false
var activeTask = "None"
var taskTool = "None"
var currentScore = 0
var failedTasks = 0
var mature = false
var matureQuality
var startOnTimeChange = false
@export var taskAvailableLength = 160

var wateringIcon = load("res://Art/ui/WaterTask.png")
var weedingIcon = load("res://Art/ui/VineTask.png")
var fertilizingIcon = load("res://Art/ui/FertilizerTask.png")

@onready var plant_growth_vfx : Node3D
@onready var plant_harvest_vfx : GPUParticles3D

func _ready() -> void:
	Global.timeOfDay.connect(timeFunc)
	audio_manager.play_planting_sound()

func construct(plantTypeN, growTimeN, taskTimesN, qualityScoresN, careTypesN, careTimesN):
	plantType = plantTypeN
	plantTexture.texture = load("res://Art/objects/" + str(plantType) + " Seed.png")
	maxGrowTime = growTimeN
	for i in taskTimes.size():
		taskTimes[i] = taskTimesN[i]
	for i in qualityScores.size():
		qualityScores[i] = qualityScoresN[i]
	for i in careTypes.size():
		if careTypesN[i] == "True":
			careTypes[i] = true
		else:
			careTypes[i] = false
	for i in careTimes.size():
		if careTimesN[i] == "True":
			careTimes[i] = true
		else:
			careTimes[i] = false
	if Global.isDay && careTimes[0]:
		startNextTask()
	elif !Global.isDay && careTimes[1]:
		startNextTask()
	else:
		startOnTimeChange = true
	
	

#Need changing of texture depending on growth
func _process(_delta: float) -> void:
	devInfo.text = "GrowTime: " + str(curGrowTime)
	devInfo.text += "\nNextTaskTime: " + str(nextTaskTime)
	devInfo.text += "\nTask Expires: " + str(previousTaskTime + taskAvailableLength)
	devInfo.text += "\nCurrentTask: " + str(activeTask)
	devInfo.text += "\nScore: " + str(currentScore) + " / (" + str(qualityScores[0]) + "," + str(qualityScores[1]) + "," + str(qualityScores[2]) + "," + str(qualityScores[2] + 2) + ")"
	devInfo.text += "\nFailed: " + str(failedTasks)
	devInfo.text += "\nMaximum Grow Time: " + str(maxGrowTime)
	if curGrowTime >= maxGrowTime:
		if currentScore >= qualityScores[2]:
			goMature(3)
		elif currentScore >= qualityScores[1]:
			goMature(2)
		elif currentScore >= qualityScores[0]:
			goMature(1)
		else:
			wither()
	if failedTasks >= qualityScores[1]:
		wither()
	if currentScore >= qualityScores[2] + 2:
		goMature(3)

func completeTask():
	currentScore += 1
	if currentScore == qualityScores[0]:
		plantTexture.texture = load("res://Art/objects/" + str(plantType) + " Sprout.png")
		if plant_growth_vfx:
			for child in plant_growth_vfx.get_children():
				if child.name == "PlantGrowthParticles" or "PlantGrowthParticles2" and child is GPUParticles3D:
					child.restart()
					child.emitting = true
	#$PlantGrowthFX.playEffect()
	activeTask = "None"
	taskActive = false
	$TaskIcon.hide()
	$TaskIcon.modulate = Color.WHITE 
		
func timeFunc(_currentTime, isDay):
	if startOnTimeChange:
		if isDay && careTimes[0]:
			startNextTask()
			startOnTimeChange = false
		elif !isDay && careTimes[1]:
			startNextTask()
			startOnTimeChange = false
	if !mature:
		curGrowTime += 1
		#if isDay && careTimes[0]:
			#curGrowTime += 1
		#elif !isDay && careTimes[1]:
			#curGrowTime += 1
		if curGrowTime == nextTaskTime:
			startNextTask()
		if previousTaskTime + taskAvailableLength == curGrowTime && taskActive:
			failedTasks += 1
			activeTask = "None"
			$TaskIcon.hide()
			$TaskIcon.modulate = Color.WHITE 
			taskActive = false
	
func goMature(plantValue):
	$TaskIcon.show()
	$TaskIcon.texture = load("res://Art/ui/NotifBubble.png")
	mature = true
	matureQuality = plantValue
	plantTexture.texture = load("res://Art/objects/" + str(plantType) + " Grown.png")
	
	if plant_harvest_vfx:
		plant_harvest_vfx.restart()
		plant_harvest_vfx.emitting = true
	
func wither():
	soil.occupied = false
	soil.togglePrepared()
	soil.remove_child(get_child(0))
	self.queue_free()

func harvest():
	if currentScore >= qualityScores[2]:
		PlayerInventory.add_item(str(plantType), 3)
	elif currentScore >= qualityScores[1]:
		PlayerInventory.add_item(str(plantType), 2)
	elif currentScore >= qualityScores[0]:
		PlayerInventory.add_item(str(plantType), 1)
	audio_manager.play_harvesting_sound()
	soil.occupied = false
	soil.togglePrepared()
	soil.remove_child(get_child(0))
	self.queue_free()
	
func startNextTask():
	previousTaskTime = curGrowTime
	nextTaskTime = random.randi_range(taskTimes[0], taskTimes[1]) + previousTaskTime
	var task = random.randi_range(1, 3)
	while !careTypes[task - 1]:
		task = random.randi_range(1, 3)
	match task:
		1:
			activeTask = "Water"	
			taskTool = "Bucket"
			$TaskIcon.texture = wateringIcon
		2:
			activeTask = "Weed"
			taskTool = "Glove"
			$TaskIcon.texture = weedingIcon
		3:
			activeTask = "Fertilize"
			taskTool = "Hoe"
			$TaskIcon.texture = fertilizingIcon
	$TaskIcon.modulate = Color.WHITE
	$TaskIcon.show()
	taskActive = true
	var tween = create_tween()
	tween.tween_property($TaskIcon, "modulate", Color.RED, 53)
	
