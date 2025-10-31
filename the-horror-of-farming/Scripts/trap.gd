extends Area3D

@export var damage_dealt := 100

var data = [1]
var durability = 100

func _on_body_entered(body: Node3D) -> void:
	print("trap %s found body %s" % [get_parent().name, body.name])
	
	if body as Hound == null:
		return
	
	(body as Hound).queue_free()

func _on_body_exited(body: Node3D) -> void:
	if body as Hound == null:
		return
	
	# ??? for edgecases maybe
