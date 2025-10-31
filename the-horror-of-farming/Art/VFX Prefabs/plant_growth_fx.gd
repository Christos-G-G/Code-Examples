extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlantGrowthParticles.emitting = false
	$PlantGrowthParticles2.emitting = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playEffect():
	$PlantGrowthParticles.restart()
	$PlantGrowthParticles2.restart()
