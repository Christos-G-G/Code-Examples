extends TileMapLayer

var tiles
var level1
var level1Detection
var level2
var level2Detection
var level3
var level3Detection
var level4
var level4Detection
var level5
var level5Detection
var level6
var level6Detection
var level7
var level7Detection
var level8
var level8Detection
var level9
var level9Detection
var level10
var level10Detection
var level11
var level11Detection
var level12
var level12Detection
var level13
var level13Detection
var level14
var level14Detection
var level15
var level15Detection
var level16
var level16Detection
var curLevel = 1
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tiles = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, $"Row 1/1,1", $"Row 1/1,2", $"Row 1/1,3", $"Row 1/1,4", $"Row 1/1,5", $"Row 1/1,6", $"Row 1/1,7", $"Row 1/1,8", $"Row 1/1,9", $"Row 1/1,10", $"Row 1/1,11", $"Row 1/1,12", null],
			 [null, $"Row 2/2,1", $"Row 2/2,2", $"Row 2/2,3", $"Row 2/2,4", $"Row 2/2,5", $"Row 2/2,6", $"Row 2/2,7", $"Row 2/2,8", $"Row 2/2,9", $"Row 2/2,10", $"Row 2/2,11", $"Row 2/2,12", null],
			 [null, $"Row 3/3,1", $"Row 3/3,2", $"Row 3/3,3", $"Row 3/3,4", $"Row 3/3,5", $"Row 3/3,6", $"Row 3/3,7", $"Row 3/3,8", $"Row 3/3,9", $"Row 3/3,10", $"Row 3/3,11", $"Row 3/3,12", null],
			 [null, $"Row 4/4,1", $"Row 4/4,2", $"Row 4/4,3", $"Row 4/4,4", $"Row 4/4,5", $"Row 4/4,6", $"Row 4/4,7", $"Row 4/4,8", $"Row 4/4,9", $"Row 4/4,10", $"Row 4/4,11", $"Row 4/4,12", null],
			 [null, $"Row 5/5,1", $"Row 5/5,2", $"Row 5/5,3", $"Row 5/5,4", $"Row 5/5,5", $"Row 5/5,6", $"Row 5/5,7", $"Row 5/5,8", $"Row 5/5,9", $"Row 5/5,10", $"Row 5/5,11", $"Row 5/5,12", null],
			 [null, $"Row 6/6,1", $"Row 6/6,2", $"Row 6/6,3", $"Row 6/6,4", $"Row 6/6,5", $"Row 6/6,6", $"Row 6/6,7", $"Row 6/6,8", $"Row 6/6,9", $"Row 6/6,10", $"Row 6/6,11", $"Row 6/6,12", null],
			 [null, $"Row 7/7,1", $"Row 7/7,2", $"Row 7/7,3", $"Row 7/7,4", $"Row 7/7,5", $"Row 7/7,6", $"Row 7/7,7", $"Row 7/7,8", $"Row 7/7,9", $"Row 7/7,10", $"Row 7/7,11", $"Row 7/7,12", null],
			 [null, $"Row 8/8,1", $"Row 8/8,2", $"Row 8/8,3", $"Row 8/8,4", $"Row 8/8,5", $"Row 8/8,6", $"Row 8/8,7", $"Row 8/8,8", $"Row 8/8,9", $"Row 8/8,10", $"Row 8/8,11", $"Row 8/8,12", null],
			 [null, $"Row 9/9,1", $"Row 9/9,2", $"Row 9/9,3", $"Row 9/9,4", $"Row 9/9,5", $"Row 9/9,6", $"Row 9/9,7", $"Row 9/9,8", $"Row 9/9,9", $"Row 9/9,10", $"Row 9/9,11", $"Row 9/9,12", null],
			 [null, $"Row 10/10,1", $"Row 10/10,2", $"Row 10/10,3", $"Row 10/10,4", $"Row 10/10,5", $"Row 10/10,6", $"Row 10/10,7", $"Row 10/10,8", $"Row 10/10,9", $"Row 10/10,10", $"Row 10/10,11", $"Row 10/10,12", null],
			 [null, $"Row 11/11,1", $"Row 11/11,2", $"Row 11/11,3", $"Row 11/11,4", $"Row 11/11,5", $"Row 11/11,6", $"Row 11/11,7", $"Row 11/11,8", $"Row 11/11,9", $"Row 11/11,10", $"Row 11/11,11", $"Row 11/11,12", null],
			 [null, $"Row 12/12,1", $"Row 12/12,2", $"Row 12/12,3", $"Row 12/12,4", $"Row 12/12,5", $"Row 12/12,6", $"Row 12/12,7", $"Row 12/12,8", $"Row 12/12,9", $"Row 12/12,10", $"Row 12/12,11", $"Row 12/12,12", null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
#1 - Open/Ground, 2 - Wall, 3 - Water, 4 - Spawn, 5 - Goal
	level1 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 5, 1, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, null],
			 [null, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, null],
			 [null, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, null],
			 [null, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, null],
			 [null, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 2, null],
			 [null, 1, 1, 1, 1, 2, 1, 1, 1, 2, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, null],
			 [null, 1, 4, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level2 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, null],
			 [null, 1, 4, 1, 1, 1, 1, 1, 2, 2, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, null],
			 [null, 1, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, null],
			 [null, 2, 1, 1, 5, 1, 1, 2, 2, 2, 3, 2, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level3 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 1, 1, 4, 1, 1, 2, 2, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, null],
			 [null, 2, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 1, 5, null],
			 [null, 2, 2, 2, 2, 2, 2, 1, 1, 1, 3, 3, 1, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level4 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, null],
			 [null, 3, 1, 1, 3, 3, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 4, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 3, 1, 2, 2, 3, 3, 1, 1, 1, 3, 3, 3, null],
			 [null, 3, 2, 2, 2, 2, 3, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 2, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 2, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 1, 1, 5, 1, 1, 3, 3, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	
	
	
	level5 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 1, 1, 4, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 3, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 1, 1, 5, 1, 1, 3, 3, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level6 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 2, 1, 4, 1, 1, 3, 3, 3, null],
			 [null, 2, 1, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 5, 1, 1, 1, 2, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 3, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 3, 3, 3, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 3, 3, 3, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 3, 3, 3, 3, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 3, 3, 3, 3, 3, 1, 3, 3, 3, 3, 3, 3, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level7 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 3, 3, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, null],
			 [null, 3, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, null],
			 [null, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level8 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 3, 3, 3, 3, 2, 2, 2, 3, 3, 2, 2, 2, null],
			 [null, 3, 3, 3, 3, 2, 2, 3, 2, 2, 2, 3, 3, null],
			 [null, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 2, 3, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, null],
			 [null, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 3, 3, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	
	
	
	level9 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, null],
			 [null, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1, null],
			 [null, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 4, null],
			 [null, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 3, 3, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level10 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 2, 1, 1, 1, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 5, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 2, 1, 1, 1, 3, 3, 3, 1, 1, 1, 1, null],
			 [null, 2, 1, 1, 1, 3, 3, 3, 3, 3, 3, 1, 1, null],
			 [null, 2, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, null],
			 [null, 2, 1, 1, 1, 1, 3, 1, 3, 3, 1, 1, 1, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, null],
			 [null, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level11 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, null],
			 [null, 5, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, null],
			 [null, 4, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, null],
			 [null, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level12 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, null],
			 [null, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 5, null],
			 [null, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, null],
			 [null, 3, 3, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, null],
			 [null, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	
	
	
	level13 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, null],
			 [null, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 5, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, null],
			 [null, 1, 1, 2, 1, 1, 1, 3, 3, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, null],
			 [null, 4, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, null],
			 [null, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level14 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, null],
			 [null, 2, 1, 1, 3, 1, 1, 1, 1, 1, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, null],
			 [null, 4, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 2, null],
			 [null, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 1, 2, null],
			 [null, 1, 1, 1, 1, 3, 3, 3, 3, 3, 1, 1, 2, null],
			 [null, 3, 1, 3, 3, 3, 3, 3, 3, 1, 1, 1, 2, null],
			 [null, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 2, null],
			 [null, 3, 3, 1, 3, 1, 3, 1, 1, 1, 1, 1, 2, null],
			 [null, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, null],
			 [null, 3, 1, 5, 1, 1, 1, 1, 1, 1, 2, 2, 2, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level15 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 3, 4, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, null],
			 [null, 2, 3, 3, 3, 1, 1, 1, 3, 1, 1, 1, 2, null],
			 [null, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 2, 2, null],
			 [null, 3, 3, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, null],
			 [null, 3, 3, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, null],
			 [null, 3, 3, 3, 1, 1, 1, 1, 1, 1, 3, 1, 5, null],
			 [null, 3, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 2, null],
			 [null, 3, 3, 3, 1, 1, 2, 2, 2, 1, 1, 1, 2, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level16 = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, null],
			 [null, 3, 3, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, null],
			 [null, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 3, 2, null],
			 [null, 3, 3, 3, 2, 2, 2, 1, 1, 1, 2, 2, 2, null],
			 [null, 3, 2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, null],
			 [null, 2, 2, 2, 2, 1, 1, 1, 5, 1, 1, 2, 2, null],
			 [null, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, null],
			 [null, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, null],
			 [null, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, null],
			 [null, 4, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, null],
			 [null, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, null],
			 [null, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, null],
			 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	
	
	
	#0 - Nothing, 1 - Detection area, 2 - Eye N, 3 - Eye E, 4 - Eye S, 5 - Eye W
	level1Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level2Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level3Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 1, 1, 1, 1, 1, 5, 0, 0, 0, 0, 0, 0, null],
					 [null, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, null],
					 [null, 3, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level4Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 2, 0, 0, 0, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 3, 0, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level5Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, null],
					 [null, 3, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level6Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 3, 1, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level7Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 0, 0, 0, 4, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, null],
					 [null, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level8Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0, 0, null],
					 [null, 0, 0, 0, 4, 0, 0, 1, 1, 0, 1, 0, 0, null],
					 [null, 0, 0, 4, 1, 0, 0, 1, 1, 0, 1, 0, 0, null],
					 [null, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, null],
					 [null, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, null],
					 [null, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, null],
					 [null, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, null],
					 [null, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level9Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, null],
					 [null, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, null],
					 [null, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level10Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 2, 3, 1, 1, 1, 1, null],
					 [null, 0, 1, 1, 1, 5, 0, 0, 0, 0, 3, 1, 1, null],
					 [null, 0, 1, 0, 0, 0, 0, 4, 0, 3, 1, 1, 1, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 3, 1, 1, 1, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level11Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level12Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 1, 0, 0, 4, 0, 0, 0, null],
					 [null, 0, 1, 1, 1, 1, 1, 1, 1, 1, 5, 0, 0, null],
					 [null, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, null],
					 [null, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level13Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, null],
					 [null, 1, 1, 3, 1, 1, 1, 0, 0, 2, 0, 0, 0, null],
					 [null, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, null],
					 [null, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 0, 0, null],
					 [null, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level14Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 1, 1, 0, 0, 0, 0, 3, 1, 1, 1, 0, null],
					 [null, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 1, 0, 0, 0, 0, 0, 3, 1, 1, 1, 0, null],
					 [null, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level15Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 4, 3, 1, 1, 1, 1, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 2, 0, 1, 1, 1, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	level16Detection = [[null, null, null, null, null, null, null, null, null, null, null, null, null, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, null],
					 [null, null, null, null, null, null, null, null, null, null, null, null, null, null]]
	buildLevel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curLevel != Global.level:
		$"../WinText".hide()
		curLevel = Global.level
		buildLevel()
	
func buildLevel():
	match curLevel:
		1:
			makeLevel(level1)	
			makeDetection(level1Detection)
		2:
			makeLevel(level2)
			makeDetection(level2Detection)
		3:
			makeLevel(level3)
			makeDetection(level3Detection)
		4:
			makeLevel(level4)
			makeDetection(level4Detection)
		5:
			makeLevel(level5)
			makeDetection(level5Detection)
		6:
			makeLevel(level6)
			makeDetection(level6Detection)
		7:
			makeLevel(level7)
			makeDetection(level7Detection)
		8:
			makeLevel(level8)
			makeDetection(level8Detection)
		9:
			makeLevel(level9)
			makeDetection(level9Detection)
		10:
			makeLevel(level10)
			makeDetection(level10Detection)
		11:
			makeLevel(level11)
			makeDetection(level11Detection)
		12:
			makeLevel(level12)
			makeDetection(level12Detection)
		13:
			makeLevel(level13)
			makeDetection(level13Detection)
		14:
			makeLevel(level14)
			makeDetection(level14Detection)
		15:
			makeLevel(level15)
			makeDetection(level15Detection)
		16:
			makeLevel(level16)
			makeDetection(level16Detection)
			$"../WinText".show()
			
func makeLevel(newLevel):
	for i in len(tiles):
		for j in len(tiles[i]):
			if tiles[i][j] != null:
				if tiles[i][j].hasEye:
					var nodes = tiles[i][j].get_children()
					for k in len(nodes):
						if nodes[k].has_method("eye"):
							nodes[k].queue_free()
					tiles[i][j].hasEye = false
				if tiles[i][j].is_occupied:
					tiles[i][j].remove_occupant()
				match newLevel[i][j]:
					1:
						var textureNum = rng.randi_range(1, 3)
						tiles[i][j].find_child("Sprite2D").texture = load("res://Art/GroundTile" + str(textureNum) + ".png")
						tiles[i][j].find_child("Sprite2D").modulate = Color(1, 1, 1)
					2:
						var textureNum = rng.randi_range(1, 3)
						tiles[i][j].find_child("Sprite2D").texture = load("res://Art/WallTile" + str(textureNum) + ".png")
						tiles[i][j].add_occupant(load("res://Grid/wall.tscn").instantiate())
						tiles[i][j].get_occupant().global_position -= Vector2(0, -10)
						tiles[i][j].find_child("Sprite2D").modulate = Color(1, 1, 1)
					3:
						tiles[i][j].find_child("Sprite2D").texture = null
						tiles[i][j].add_occupant(load("res://Grid/obstacle.tscn").instantiate())
						tiles[i][j].find_child("Sprite2D").modulate = Color(1, 1, 1)
					4:	
						var textureNum = rng.randi_range(1, 3)
						tiles[i][j].find_child("Sprite2D").texture = load("res://Art/GroundTile" + str(textureNum) + ".png")
						tiles[i][j].find_child("Sprite2D").modulate = Color(1, 1, 0)
						Global.start = [i, j]
					5:
						tiles[i][j].find_child("Sprite2D").texture = load("res://Art/GoalTile.png")
						tiles[i][j].add_occupant(load("res://Grid/goal.tscn").instantiate())
						tiles[i][j].find_child("Sprite2D").modulate = Color(1, 1, 1)
						Global.goal = [i, j]
						
func makeDetection(detection):
	for i in len(tiles):
		for j in len(tiles[i]):
			if tiles[i][j] != null:
				match detection[i][j]:
					1:
						tiles[i][j].add_occupant(load("res://detection_tile.tscn").instantiate())
					2:
						var newEye = load("res://eye_visual.tscn").instantiate()
						tiles[i][j].add_child(newEye)
						tiles[i][j].hasEye = true
						newEye.texture = load("res://Art/Eye_3.PNG")
						newEye.global_position += Vector2(0, -20)
						newEye.direction = 1
					3:
						var newEye = load("res://eye_visual.tscn").instantiate()
						tiles[i][j].add_child(newEye)
						tiles[i][j].hasEye = true
						newEye.texture = load("res://Art/Eye_2.2.PNG")
						newEye.global_position += Vector2(0, -20)
						newEye.direction = 2
					4:
						var newEye = load("res://eye_visual.tscn").instantiate()
						tiles[i][j].add_child(newEye)
						tiles[i][j].hasEye = true
						newEye.texture = load("res://Art/Eye_1.2.PNG")
						newEye.global_position += Vector2(0, -20)
						newEye.direction = 3
					5:
						var newEye = load("res://eye_visual.tscn").instantiate()
						tiles[i][j].add_child(newEye)
						tiles[i][j].hasEye = true
						newEye.texture = load("res://Art/Eye_4.PNG")
						newEye.global_position += Vector2(0, -20)
						newEye.direction = 4
						
	pass


func _on_button_pressed():
	$"../WinText".hide()
	get_tree().change_scene_to_file("res://Menus/menu.tscn")
	curLevel = 1
	Global.level = 1
	Global.loadLevelCoords()
