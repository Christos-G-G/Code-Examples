extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlantHarvestParticles.emitting = false
	$PlantHarvestParticleTrails.emitting = false
	$PulseShaderEffect.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playEffect():
	$Timer.start()
	$PlantHarvestParticles.restart()
	$PlantHarvestParticleTrails.restart()
	$PlantHarvestParticles.emitting = true
	$PlantHarvestParticleTrails.emitting = true
	$PulseShaderEffect.show()

func _on_timer_timeout() -> void:
	$PlantHarvestParticles.emitting = false
	$PlantHarvestParticleTrails.emitting = false
	$PulseShaderEffect.hide()
	pass # Replace with function body.
