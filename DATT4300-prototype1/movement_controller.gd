extends Node2D

var moving = false
var moveSelection = 0
var player
var animator
var animating = false
var danceSpeed = 0.02

var followNode
var currentPathway
var curPos
var tiles
var level = 1
var path


var northPathScan
var eastPathScan
var southPathScan
var westPathScan
var northPathTiles
var eastPathTiles
var southPathTiles
var westPathTiles
var northEnabled = false
var eastEnabled = false
var southEnabled = false
var westEnabled = false

var rng = RandomNumberGenerator.new()
var screenWipe
var screenWipeStart = Vector2(-325, 80)

func _ready() -> void:
	show_player()
	
	player = $"../Player"
	tiles = $"../Tiles".tiles
	path = $MovementCenter/Path
	followNode = $MovementCenter/Path/Follow
	screenWipe = $"../ScreenWipe"
	animator = player.find_child("Anim")
	newLevel()
	pass

func _process(delta: float) -> void:
	#match moveSelection:
		#0:
			#pass
		#1:
			#pass
		#2:
			#pass
		#3:
			#pass
		#4:
			#pass
			
	if moving:
		show_player()
		
		followNode.progress_ratio += danceSpeed
		player.global_position = followNode.global_position
		animator.play("Twirl")
		if followNode.progress_ratio >= 0.975:
			followNode.progress_ratio = 1
			player.global_position = followNode.global_position
			stopMoving()
	if Input.is_action_just_pressed("danceOne"):
		if !moving && !animating:
			show_player()
			updateMoves()
			setMove(1)
			$"../MarginContainer2/1Down".show()
			$"../MarginContainer2/1Up".hide()
			$"../MarginContainer2/2Down".hide()
			$"../MarginContainer2/2Up".show()
			$"../MarginContainer2/3Down".hide()
			$"../MarginContainer2/3Up".show()
			$"../MarginContainer2/4Down".hide()
			$"../MarginContainer2/4Up".show()
			$"../MarginContainer2/Step1".show()
			$"../MarginContainer2/Step2".hide()
			$"../MarginContainer2/Step3".hide()
			$"../MarginContainer2/Step4".hide()
	if Input.is_action_just_pressed("danceTwo"):
		if !moving && !animating:
			show_player()
			updateMoves()
			setMove(2)
			$"../MarginContainer2/1Down".hide()
			$"../MarginContainer2/1Up".show()
			$"../MarginContainer2/2Down".show()
			$"../MarginContainer2/2Up".hide()
			$"../MarginContainer2/3Down".hide()
			$"../MarginContainer2/3Up".show()
			$"../MarginContainer2/4Down".hide()
			$"../MarginContainer2/4Up".show()
			$"../MarginContainer2/Step1".hide()
			$"../MarginContainer2/Step2".show()
			$"../MarginContainer2/Step3".hide()
			$"../MarginContainer2/Step4".hide()
	if Input.is_action_just_pressed("danceThree"):
		if !moving && !animating:
			updateMoves()
			hide_player()
			setMove(3)
			$"../MarginContainer2/1Down".hide()
			$"../MarginContainer2/1Up".show()
			$"../MarginContainer2/2Down".hide()
			$"../MarginContainer2/2Up".show()
			$"../MarginContainer2/3Down".show()
			$"../MarginContainer2/3Up".hide()
			$"../MarginContainer2/4Down".hide()
			$"../MarginContainer2/4Up".show()
			$"../MarginContainer2/Step1".hide()
			$"../MarginContainer2/Step2".hide()
			$"../MarginContainer2/Step3".show()
			$"../MarginContainer2/Step4".hide()
	if Input.is_action_just_pressed("danceFour"):
		if !moving && !animating:
			show_player()
			updateMoves()
			setMove(4)
			$"../MarginContainer2/1Down".hide()
			$"../MarginContainer2/1Up".show()
			$"../MarginContainer2/2Down".hide()
			$"../MarginContainer2/2Up".show()
			$"../MarginContainer2/3Down".hide()
			$"../MarginContainer2/3Up".show()
			$"../MarginContainer2/4Down".show()
			$"../MarginContainer2/4Up".hide()
			$"../MarginContainer2/Step1".hide()
			$"../MarginContainer2/Step2".hide()
			$"../MarginContainer2/Step3".hide()
			$"../MarginContainer2/Step4".show()
	if Input.is_action_just_pressed("restart"):
		if !moving && !animating:
			newLevel()
	if northEnabled:
		$MovementCenter/NorthPreview.show()
	else:
		$MovementCenter/NorthPreview.hide()
	if eastEnabled:
		$MovementCenter/EastPreview.show()
	else:
		$MovementCenter/EastPreview.hide()
	if southEnabled:
		$MovementCenter/SouthPreview.show()
	else:
		$MovementCenter/SouthPreview.hide()
	if westEnabled:
		$MovementCenter/WestPreview.show()
	else:
		$MovementCenter/WestPreview.hide()
	if northEnabled:
		match moveSelection:
			1:
				$MovementCenter/Path1_1.show()
				$MovementCenter/Path2_1.hide()
				$MovementCenter/Path3_1.hide()
				$MovementCenter/Path4_1.hide()
			2:
				$MovementCenter/Path1_1.hide()
				$MovementCenter/Path2_1.show()
				$MovementCenter/Path3_1.hide()
				$MovementCenter/Path4_1.hide()
			3:
				$MovementCenter/Path1_1.hide()
				$MovementCenter/Path2_1.hide()
				$MovementCenter/Path3_1.show()
				$MovementCenter/Path4_1.hide()
			4:
				$MovementCenter/Path1_1.hide()
				$MovementCenter/Path2_1.hide()
				$MovementCenter/Path3_1.hide()
				$MovementCenter/Path4_1.show()
	if eastEnabled:
		match moveSelection:
			1:
				$MovementCenter/Path1_2.show()
				$MovementCenter/Path2_2.hide()
				$MovementCenter/Path3_2.hide()
				$MovementCenter/Path4_2.hide()
			2:
				$MovementCenter/Path1_2.hide()
				$MovementCenter/Path2_2.show()
				$MovementCenter/Path3_2.hide()
				$MovementCenter/Path4_2.hide()
			3:
				$MovementCenter/Path1_2.hide()
				$MovementCenter/Path2_2.hide()
				$MovementCenter/Path3_2.show()
				$MovementCenter/Path4_2.hide()
			4:
				$MovementCenter/Path1_2.hide()
				$MovementCenter/Path2_2.hide()
				$MovementCenter/Path3_2.hide()
				$MovementCenter/Path4_2.show()
	if southEnabled:
		match moveSelection:
			1:
				$MovementCenter/Path1_3.show()
				$MovementCenter/Path2_3.hide()
				$MovementCenter/Path3_3.hide()
				$MovementCenter/Path4_3.hide()
			2:
				$MovementCenter/Path1_3.hide()
				$MovementCenter/Path2_3.show()
				$MovementCenter/Path3_3.hide()
				$MovementCenter/Path4_3.hide()
			3:
				$MovementCenter/Path1_3.hide()
				$MovementCenter/Path2_3.hide()
				$MovementCenter/Path3_3.show()
				$MovementCenter/Path4_3.hide()
			4:
				$MovementCenter/Path1_3.hide()
				$MovementCenter/Path2_3.hide()
				$MovementCenter/Path3_3.hide()
				$MovementCenter/Path4_3.show()
	if westEnabled:
		match moveSelection:
			1:
				$MovementCenter/Path1_4.show()
				$MovementCenter/Path2_4.hide()
				$MovementCenter/Path3_4.hide()
				$MovementCenter/Path4_4.hide()
			2:
				$MovementCenter/Path1_4.hide()
				$MovementCenter/Path2_4.show()
				$MovementCenter/Path3_4.hide()
				$MovementCenter/Path4_4.hide()
			3:
				$MovementCenter/Path1_4.hide()
				$MovementCenter/Path2_4.hide()
				$MovementCenter/Path3_4.show()
				$MovementCenter/Path4_4.hide()
			4:
				$MovementCenter/Path1_4.hide()
				$MovementCenter/Path2_4.hide()
				$MovementCenter/Path3_4.hide()
				$MovementCenter/Path4_4.show()
				
func updateMoves():
	$MovementCenter/Path1_1.hide()
	$MovementCenter/Path2_1.hide()
	$MovementCenter/Path3_1.hide()
	$MovementCenter/Path4_1.hide()
	$MovementCenter/Path1_2.hide()
	$MovementCenter/Path2_2.hide()
	$MovementCenter/Path3_2.hide()
	$MovementCenter/Path4_2.hide()
	$MovementCenter/Path1_3.hide()
	$MovementCenter/Path2_3.hide()
	$MovementCenter/Path3_3.hide()
	$MovementCenter/Path4_3.hide()
	$MovementCenter/Path1_4.hide()
	$MovementCenter/Path2_4.hide()
	$MovementCenter/Path3_4.hide()
	$MovementCenter/Path4_4.hide()
#-------------------------------------------Movement Setup, Path Checking
func setMove(move) -> void:
	moveSelection = move
	match move:
		1:
			if curPos[0] >= 3 && curPos[1] >= 2:
				northEnabled = true
				var _path = [[0,0],[-1,0],[-1,-1],[-2,-1],[-2,0]]
				buildNorthPath(_path)
			else:
				northEnabled = false
				
			if curPos[0] >= 2 && curPos[1] <= 11:
				eastEnabled = true
				var _path = [[0,0],[-1,0],[-1,1],[0,1]]
				buildEastPath(_path)
			else:
				eastEnabled = false
				
			if curPos[0] <= 10 && curPos[1] <= 11:
				southEnabled = true
				var _path = [[0,0],[1,0],[1,1],[2,1],[2,0]]
				buildSouthPath(_path)
			else:
				southEnabled = false
				
			if curPos[0] <= 11 && curPos[1] >= 2:
				westEnabled = true
				var _path = [[0,0],[1,0],[1,-1],[0,-1]]
				buildWestPath(_path)
			else:
				westEnabled = false
				
		2:
			if curPos[0] >= 3 && curPos[1] <= 10:
				northEnabled = true
				var _path = [[0,0],[-1,0],[-1,1],[-2,1],[-2,2]]
				buildNorthPath(_path)
			else:
				northEnabled = false
				
			if curPos[0] <= 11 && curPos[1] <= 9:
				eastEnabled = true
				var _path = [[0,0],[0,1],[1,1],[1,2],[0,2],[0,3]]
				buildEastPath(_path)
			else:
				eastEnabled = false
				
			if curPos[0] <= 10 && curPos[1] >= 3:
				southEnabled = true
				var _path = [[0,0],[1,0],[1,-1],[2,-1],[2,-2]]
				buildSouthPath(_path)
			else:
				southEnabled = false
				
			if curPos[0] >= 2 && curPos[1] >= 4:
				westEnabled = true
				var _path = [[0,0],[0,-1],[-1,-1],[-1,-2],[0,-2],[0,-3]]
				buildWestPath(_path)
			else:
				westEnabled = false
				
		3:
			if curPos[0] >= 3 && curPos[1] >= 2:
				northEnabled = true
				var _path = [[0,0],[-1,0],[-2,0],[-2,-1]]
				buildNorthPath(_path)
			else:
				northEnabled = false
				
			if curPos[0] <= 11 && curPos[1] <= 11:
				eastEnabled = true
				var _path = [[0,0],[0,1],[1,1]]
				buildEastPath(_path)
			else:
				eastEnabled = false
				
			if curPos[0] <= 10 && curPos[1] <= 11:
				southEnabled = true
				var _path = [[0,0],[1,0],[2,0],[2,1]]
				buildSouthPath(_path)
			else:
				southEnabled = false
				
			if curPos[0] >= 2 && curPos[1] >= 2:
				westEnabled = true
				var _path = [[0,0],[0,-1],[-1,-1]]
				buildWestPath(_path)
			else:
				westEnabled = false
				
		4:
			if curPos[0] >= 3 && curPos[1] <= 11:
				northEnabled = true
				var _path = [[0,0],[0,1],[-1,1],[-1,0],[-2,0],[-2,1]]
				buildNorthPath(_path)
			else:
				northEnabled = false
				
			if curPos[0] >= 2 && curPos[1] >= 2 && curPos[1] <= 11:
				eastEnabled = true
				var _path = [[0,0],[0,-1],[-1,-1],[-1,0],[-1,1]]
				buildEastPath(_path)
			else:
				eastEnabled = false
				
			if curPos[0] <= 10 && curPos[1] >= 2:
				southEnabled = true
				var _path = [[0,0],[0,-1],[1,-1],[1,0],[2,0],[2,-1]]
				buildSouthPath(_path)
			else:
				southEnabled = false
				
			if curPos[0] <= 11 && curPos[1] >= 2 && curPos[1] <= 11:
				westEnabled = true
				var _path = [[0,0],[0,1],[1,1],[1,0],[1,-1]]
				buildWestPath(_path)
			else:
				westEnabled = false

func addArrays(array1, array2):
	var newArray = [array1[0] + array2[0], array1[1] + array2[1]]
	return newArray

func buildNorthPath(_path):
	northPathTiles = []
	for i in len(_path):
		var next_coords = addArrays(curPos, _path[i])
		northPathTiles.append(next_coords)
	$MovementCenter/NorthPreview.global_position = tiles[northPathTiles[-1][0]][northPathTiles[-1][1]].global_position + Vector2(0, -1)
	northPathScan = []
	for i in range(1, len(northPathTiles)):
		northPathScan.append(tiles[northPathTiles[i][0]][northPathTiles[i][1]])
	for i in len(northPathScan):
		if northPathScan[i].occupantType == 2 or northPathScan[i].hasEye:
			northEnabled = false
	
func buildEastPath(_path):
	eastPathTiles = []
	for i in len(_path):
		var next_coords = addArrays(curPos, _path[i])
		eastPathTiles.append(next_coords)
	$MovementCenter/EastPreview.global_position = tiles[eastPathTiles[-1][0]][eastPathTiles[-1][1]].global_position + Vector2(0, -1)
	eastPathScan = []
	for i in range(1, len(eastPathTiles)):
		eastPathScan.append(tiles[eastPathTiles[i][0]][eastPathTiles[i][1]])
	for i in len(eastPathScan):
		if eastPathScan[i].occupantType == 2 or eastPathScan[i].hasEye:
			eastEnabled = false
	
func buildSouthPath(_path):
	southPathTiles = []
	for i in len(_path):
		var next_coords = addArrays(curPos, _path[i])
		southPathTiles.append(next_coords)
	$MovementCenter/SouthPreview.global_position = tiles[southPathTiles[-1][0]][southPathTiles[-1][1]].global_position + Vector2(0, -1)
	southPathScan = []
	for i in range(1, len(southPathTiles)):
		southPathScan.append(tiles[southPathTiles[i][0]][southPathTiles[i][1]])
	for i in len(southPathScan):
		if southPathScan[i].occupantType == 2 or southPathScan[i].hasEye:
			southEnabled = false
	
func buildWestPath(_path):
	westPathTiles = []
	for i in len(_path):
		var next_coords = addArrays(curPos, _path[i])
		westPathTiles.append(next_coords)
	$MovementCenter/WestPreview.global_position = tiles[westPathTiles[-1][0]][westPathTiles[-1][1]].global_position + Vector2(0, -1)
	westPathScan = []
	for i in range(1, len(westPathTiles)):
		westPathScan.append(tiles[westPathTiles[i][0]][westPathTiles[i][1]])
	for i in len(westPathScan):
		if westPathScan[i].occupantType == 2 or westPathScan[i].hasEye:
			westEnabled = false
			
#----------------------------------------------Active Movement
func followPath(pathway, finalPos) -> void:
	match moveSelection:
		1:
			match pathway:
				1:
					path.curve.set_point_count(5)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, -8))
					path.curve.set_point_position(2, Vector2(0, -16))
					path.curve.set_point_position(3, Vector2(16, -24))
					path.curve.set_point_position(4, Vector2(32, -16))
				2:
					path.curve.set_point_count(4)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, -8))
					path.curve.set_point_position(2, Vector2(32, 0))
					path.curve.set_point_position(3, Vector2(16, 8))
				3:
					path.curve.set_point_count(5)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, 8))
					path.curve.set_point_position(2, Vector2(0, 16))
					path.curve.set_point_position(3, Vector2(-16, 24))
					path.curve.set_point_position(4, Vector2(-32, 16))
				4:
					path.curve.set_point_count(4)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, 8))
					path.curve.set_point_position(2, Vector2(-32, 0))
					path.curve.set_point_position(3, Vector2(-16, -8))
		2:
			match pathway:
				1:
					path.curve.set_point_count(5)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, -8))
					path.curve.set_point_position(2, Vector2(32, 0))
					path.curve.set_point_position(3, Vector2(48, -8))
					path.curve.set_point_position(4, Vector2(64, 0))
				2:
					path.curve.set_point_count(6)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, 8))
					path.curve.set_point_position(2, Vector2(0, 16))
					path.curve.set_point_position(3, Vector2(16, 24))
					path.curve.set_point_position(4, Vector2(32, 16))
					path.curve.set_point_position(5, Vector2(48, 24))
				3:
					path.curve.set_point_count(5)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, 8))
					path.curve.set_point_position(2, Vector2(-32, 0))
					path.curve.set_point_position(3, Vector2(-48, 8))
					path.curve.set_point_position(4, Vector2(-64, 0))
				4:
					path.curve.set_point_count(6)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, -8))
					path.curve.set_point_position(2, Vector2(0, -16))
					path.curve.set_point_position(3, Vector2(-16, -24))
					path.curve.set_point_position(4, Vector2(-32, -16))
					path.curve.set_point_position(5, Vector2(-48, -24))
		3:
			match pathway:
				1:
					path.curve.set_point_count(4)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, -8))
					path.curve.set_point_position(2, Vector2(32, -16))
					path.curve.set_point_position(3, Vector2(16, -24))
				2:
					path.curve.set_point_count(3)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, 8))
					path.curve.set_point_position(2, Vector2(0, 16))
				3:
					path.curve.set_point_count(4)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, 8))
					path.curve.set_point_position(2, Vector2(-32, 16))
					path.curve.set_point_position(3, Vector2(-16, 24))
				4:
					path.curve.set_point_count(3)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, -8))
					path.curve.set_point_position(2, Vector2(0, -16))
		4:
			match pathway:
				1:
					path.curve.set_point_count(6)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, 8))
					path.curve.set_point_position(2, Vector2(32, 0))
					path.curve.set_point_position(3, Vector2(16, -8))
					path.curve.set_point_position(4, Vector2(32, -16))
					path.curve.set_point_position(5, Vector2(48, -8))
				2:
					path.curve.set_point_count(5)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, -8))
					path.curve.set_point_position(2, Vector2(0, -16))
					path.curve.set_point_position(3, Vector2(16, -8))
					path.curve.set_point_position(4, Vector2(32, 0))
				3:
					path.curve.set_point_count(6)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(-16, -8))
					path.curve.set_point_position(2, Vector2(-32, 0))
					path.curve.set_point_position(3, Vector2(-16, 8))
					path.curve.set_point_position(4, Vector2(-32, 16))
					path.curve.set_point_position(5, Vector2(-48, 8))
				4:
					path.curve.set_point_count(5)
					path.curve.set_point_position(0, Vector2(0, 0))
					path.curve.set_point_position(1, Vector2(16, 8))
					path.curve.set_point_position(2, Vector2(0, 16))
					path.curve.set_point_position(3, Vector2(-16, 8))
					path.curve.set_point_position(4, Vector2(-32, 0))
					
	currentPathway = pathway
	
	print("cur: %s | fin: %s" % [curPos, finalPos])
	
	var curTile = tiles[curPos[0] - 1][curPos[1] - 1]
	var finalTile = tiles[finalPos[0] - 1][finalPos[1] - 1]
	
	curPos = finalPos 
	moveSelection = 0
	moving = true
	
func stopMoving() -> void:
	resetMoveUI()
	updateMoves()
	$MovementCenter.global_position = player.global_position
	var pose = rng.randi_range(1, 4)
	animator.play("Pose")
	animator.set_frame(pose)
	animator.pause()
	northEnabled = false
	eastEnabled = false
	southEnabled = false
	westEnabled = false
	followNode.progress_ratio = 0
	path.curve.clear_points()
	moving = false
	if curPos == Global.goal:
		level += 1
		Global.newLevel()
		if level > Global.numberOfLevels:
			level = 1
			get_tree().change_scene_to_file("res://Menus/menu.tscn")
		else:
			newLevel()

func newLevel():
	resetMoveUI()
	curPos = Global.start
	animator.play("Pose")
	animator.set_frame(0)
	animator.pause()
	player.global_position = tiles[curPos[0]][curPos[1]].global_position
	$MovementCenter.global_position = player.global_position
	path.curve.clear_points()
	updateMoves()
	
func loseCondition(type):
	animating = true
	moving = false
	$LoseAnimation.start()
	match type:
		1:
			animator.play("FallInWater")
		2:
			animator.play("Spotted")
	
func _on_lose_animation_timeout() -> void:
	resetMoveUI()
	screenWipe.global_position = screenWipeStart
	var tween = get_tree().create_tween().bind_node(screenWipe).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(screenWipe, "position", Vector2(1100, 0), 1)
	$ScreenWipe.start()

func _on_screen_wipe_timeout() -> void:
	curPos = Global.start
	animator.play("Pose")
	animator.set_frame(0)
	animator.pause()
	player.global_position = tiles[curPos[0]][curPos[1]].global_position
	$MovementCenter.global_position = player.global_position
	updateMoves()
	northEnabled = false
	eastEnabled = false
	southEnabled = false
	westEnabled = false
	followNode.progress_ratio = 0
	path.curve.clear_points()
	moving = false
	animating = false
	
#-----------------------------------------------Buttons
func _on_n_pressed() -> void:
	if !moving:
		followPath(1, northPathTiles[-1])
func _on_e_pressed() -> void:
	if !moving:
		followPath(2, eastPathTiles[-1])
func _on_s_pressed() -> void:
	if !moving:
		followPath(3, southPathTiles[-1])
func _on_w_pressed() -> void:
	if !moving:
		followPath(4, westPathTiles[-1])
		
func resetMoveUI():
	$"../MarginContainer2/1Down".hide()
	$"../MarginContainer2/1Up".show()
	$"../MarginContainer2/2Down".hide()
	$"../MarginContainer2/2Up".show()
	$"../MarginContainer2/3Down".hide()
	$"../MarginContainer2/3Up".show()
	$"../MarginContainer2/4Down".hide()
	$"../MarginContainer2/4Up".show()
	$"../MarginContainer2/Step1".hide()
	$"../MarginContainer2/Step2".hide()
	$"../MarginContainer2/Step3".hide()
	$"../MarginContainer2/Step4".hide()
	
		
#region new changes

@onready var player_anim : CanvasItem = $"../Player/Anim"

@onready var previews = [
	$MovementCenter/NorthPreview,
	$MovementCenter/EastPreview,
	$MovementCenter/SouthPreview,
	$MovementCenter/WestPreview
]

@onready var paths = [
	$MovementCenter/Path1_1,
	$MovementCenter/Path2_1,
	$MovementCenter/Path3_1,
	$MovementCenter/Path4_1,
	
	$MovementCenter/Path1_2,
	$MovementCenter/Path2_2,
	$MovementCenter/Path3_2,
	$MovementCenter/Path4_2,
	
	$MovementCenter/Path1_3,
	$MovementCenter/Path2_3,
	$MovementCenter/Path3_3,
	$MovementCenter/Path4_3,
	
	$MovementCenter/Path1_4,
	$MovementCenter/Path2_4,
	$MovementCenter/Path3_4,
	$MovementCenter/Path4_4
]

var default_modulate = Color(1,1,1,1)
var hidden_modulate = Color(1,1,1,0.5)
var player_hidden_modulate = Color(1,1,1,0.66)

func _on_n_mouse_entered() -> void:
	hide_all_paths()
	previews[0].modulate = default_modulate
	
	paths[moveSelection - 1].modulate = default_modulate

func _on_e_mouse_entered() -> void:
	hide_all_paths()
	previews[1].modulate = default_modulate
	
	paths[moveSelection + 3].modulate = default_modulate

func _on_s_mouse_entered() -> void:
	hide_all_paths()
	previews[2].modulate = default_modulate
	
	paths[moveSelection + 7].modulate = default_modulate

func _on_w_mouse_entered() -> void:
	hide_all_paths()
	previews[3].modulate = default_modulate
	
	paths[moveSelection + 11].modulate = default_modulate

func show_all_paths() -> void:
	for a in previews:
		a.modulate = default_modulate
	for b in paths:
		b.modulate = default_modulate

func hide_all_paths() -> void:
	for a in previews:
		a.modulate = hidden_modulate
	for b in paths:
		b.modulate = hidden_modulate

func show_player() -> void:
	player_anim.modulate = default_modulate

func hide_player() -> void:
	player_anim.modulate = player_hidden_modulate

#endregion


func _on_texture_button_1_toggled(toggled_on):
	if !moving:
			updateMoves()
			setMove(1)
			$"../MarginContainer2/VBoxContainer/UIpath1".show()
			$"../MarginContainer2/VBoxContainer/UIpath2".hide()
			$"../MarginContainer2/VBoxContainer/UIpath3".hide()
			$"../MarginContainer2/VBoxContainer/UIpath4".hide()

func _on_texture_button_2_toggled(toggled_on):
	if !moving:
			updateMoves()
			setMove(2)
			$"../MarginContainer2/VBoxContainer/UIpath1".hide()
			$"../MarginContainer2/VBoxContainer/UIpath2".show()
			$"../MarginContainer2/VBoxContainer/UIpath3".hide()
			$"../MarginContainer2/VBoxContainer/UIpath4".hide()

func _on_texture_button_3_toggled(toggled_on):
	if !moving:
			updateMoves()
			setMove(3)
			$"../MarginContainer2/VBoxContainer/UIpath1".hide()
			$"../MarginContainer2/VBoxContainer/UIpath2".hide()
			$"../MarginContainer2/VBoxContainer/UIpath3".show()
			$"../MarginContainer2/VBoxContainer/UIpath4".hide()

func _on_texture_button_4_toggled(toggled_on):
	if !moving:
			updateMoves()
			setMove(4)
			$"../MarginContainer2/VBoxContainer/UIpath1".hide()
			$"../MarginContainer2/VBoxContainer/UIpath2".hide()
			$"../MarginContainer2/VBoxContainer/UIpath3".hide()
			$"../MarginContainer2/VBoxContainer/UIpath4".show()
