extends Node2D


var gameActive = false
var lane = 2
var obstacle
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	obstacle = load("res://obstacle.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match lane:
		1:
			$TransparentHorsePngClipart.position.y = 111 - 68
		2:
			$TransparentHorsePngClipart.position.y = 111
		3:
			$TransparentHorsePngClipart.position.y = 111 + 68
	
	pass
	
func _input(event: InputEvent) -> void:
	if gameActive:
		if Input.is_action_just_pressed("LClick"):
			if lane != 1:
				lane -= 1
		if Input.is_action_just_pressed("RClick"):
			if lane != 3:
				lane += 1
	
func start():
	gameActive = true
	$ObstacleSpawn.start()
	pass

func gameOver():
	$".".hide()
	$"../Tutorial".show()
	$"..".hide()
	$"../../Menu".show()
	gameActive = false
	lane = 2
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Obstacle":
		gameOver()
		$ObstacleSpawn.stop()
	pass # Replace with function body.


func _on_obstacle_spawn_timeout() -> void:
	var newObstacle = obstacle.instantiate()
	add_child(newObstacle)
	newObstacle.position.x = 278
	var lane = randi_range(1, 3)
	match lane:
		1:
			newObstacle.position.y = 111 - 68
		2:
			newObstacle.position.y = 111
		3:
			newObstacle.position.y = 111 + 68
	pass # Replace with function body.
