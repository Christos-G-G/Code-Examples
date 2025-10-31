extends Node

@export var current_pos : Vector2

# default to down (southeast), relative to cell
var scanned_tiles = [ \
		Vector2(0,1), \
		Vector2(0,2) \
	]

var last_keys = []
var scan_results = {}
var occupied_tiles = {}

@onready var tiles = $"../Tiles".tiles
@onready var scanned_tile_indicator : PackedScene = load("res://scanned_tile_sprite.tscn")

func scan() -> void:
	scan_results.clear()
	
	for n in range(len(scanned_tiles)):
		var coords := Vector2(scanned_tiles[n].x, scanned_tiles[n].y) + current_pos
		
		if coords.x > len(tiles) \
		or coords.x < 0:
			continue
		if coords.y > len(tiles[1]) \
		or coords.y < 0:
			continue
		
		var tile = tiles[coords.x][coords.y]
		
		scan_results[tile] = tile.is_occupied
	
	occupied_tiles.clear()
	
	for tile in scan_results:
		tile = tile
		var result = scan_results[tile]
		
		if result == true:
			occupied_tiles[tile] = tile.get_occupant
	
	print("Found this: %s" % occupied_tiles)
	
	update_ui()

func update_ui() -> void:
	var keys = scan_results.keys()
	
	for tile in last_keys:
		var _tile = tile as Node
		if !_tile.has_node("Scanned Tile Sprite"):
			continue
		_tile.remove_child(_tile.get_node("Scanned Tile Sprite"))
	
	for tile in keys:
		(tile as Node).add_child(scanned_tile_indicator.instantiate())
	
	last_keys = keys
