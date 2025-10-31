extends Sprite2D

const type = 2
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var textureNum = rng.randi_range(1, 3)
	self.texture = load("res://Art/WallTile" + str(textureNum) + ".png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
