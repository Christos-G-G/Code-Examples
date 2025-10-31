extends Node

var level = 1
var numberOfLevels = 16
var start
var goal
var startList = [[11, 2], [2, 2], [1, 4], [6, 2], [1, 6], [1, 7], [9, 12], [7, 12], [4, 12], [10, 12], [11, 1], [9, 12], [9, 1], [5, 1], [1, 2], [10, 1]]
var goalList = [[2, 11], [12, 4], [11, 12], [12, 7], [12, 7], [4, 1], [7, 1], [9, 1], [5, 1], [3, 12], [4, 1], [2, 12], [2, 12], [12, 3], [10, 12], [6, 8]]

func _ready():
	loadLevelCoords()
	
func newLevel():
	if level < numberOfLevels:
		level += 1
		loadLevelCoords()
	else:
		level = 1
		loadLevelCoords()

func loadLevelCoords():
	start = startList[level - 1]
	goal = goalList[level - 1]
