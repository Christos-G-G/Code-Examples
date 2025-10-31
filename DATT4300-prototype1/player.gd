extends CharacterBody2D



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("obstacle"):
		find_parent("Level").find_child("MovementController").loseCondition(1)
	if area.has_method("detection"):
		if area.get_parent().active:
			find_parent("Level").find_child("MovementController").loseCondition(2)
		
