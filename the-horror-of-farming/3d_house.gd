extends Node3D

var houseFront
var houseRoof
var objects
var tween
var transitionTime = 0.25
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	houseFront = $"3dHouseFront".get_surface_override_material(2)
	houseRoof = $"3dHouseFront".get_surface_override_material(0)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_house_interior_area_area_entered(area: Area3D) -> void:
	if area.name == "PlayerArea":
		houseFront.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		houseRoof.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		changeTransparency(houseFront, 0.25)
		changeTransparency(houseRoof, 0.25)
		
func _on_house_interior_area_area_exited(area: Area3D) -> void:
	if area.name == "PlayerArea":
		changeTransparency(houseFront, 1)
		changeTransparency(houseRoof, 1)
		await(get_tree().create_timer(transitionTime).timeout)
		houseFront.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
		houseRoof.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED

func changeTransparency(object, targetAlpha):
	tween = create_tween()
	var currentAlpha = object.albedo_color.a
	if currentAlpha != targetAlpha:
		tween.tween_method(func(alpha): object.albedo_color.a = alpha, currentAlpha, targetAlpha, transitionTime)
