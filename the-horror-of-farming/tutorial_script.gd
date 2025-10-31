extends Control

@export var tutorial_menu: Control
@export var tutorial_steps: Array[MarginContainer]

var current_tutorial_index := 0
var tween: Tween
var start_pos: Vector2
var offscreen_pos: Vector2

func _ready():
	if tutorial_steps.is_empty():
		return
	
	start_pos = tutorial_steps[0].position
	offscreen_pos = start_pos - Vector2(0, 500)
	
	for step in tutorial_steps:
		step.position = offscreen_pos
		step.visible = false
		
	slide_in(tutorial_steps[0])
	
	#Hide all tutorials excepts the first one
	for i in range(tutorial_steps.size()):
		tutorial_steps[i].visible = (i == 0)

#Called when a tutorial action is completed
func complete_tutorial():
	if current_tutorial_index < tutorial_steps.size() - 1:
		var current_tut = tutorial_steps[current_tutorial_index]
		var next_tut = tutorial_steps[current_tutorial_index + 1]
		
		await slide_out(current_tut)
		slide_in(next_tut)
		print(current_tutorial_index)
		current_tutorial_index += 1
	else:
		slide_out(tutorial_steps[current_tutorial_index])
		print("All Tutorials Completed!")


#Function to listen for actions
func check_tut_progress(action: String):
	match  current_tutorial_index:
		0:
			if action == "Pick Up Hoe":
				complete_tutorial()
				
		1:
			if action == "Use Hoe":
				complete_tutorial()
				
		2: 
			if action == "Drop Hoe":
				complete_tutorial()
				
		3:
			if action == "Select Radish Seed":
				complete_tutorial()
				
		4:
			if action == "Plant Seed":
				complete_tutorial()
				
		5:
			if action == "Pick Up Water Can" or action == "Pick Up Gloves":
				complete_tutorial()
			
		6:
			if action == "Fill Water Can":
				complete_tutorial()
				
		7:
			if action == "Buy More Seeds":
				complete_tutorial()
				await(get_tree().create_timer(10).timeout)
				complete_tutorial()
				await(get_tree().create_timer(10).timeout)
				complete_tutorial()
				
		8:
			if action == "Pick Up Trap":
				complete_tutorial()
				
		9:
			if action == "Sell Crop":
				complete_tutorial()

func slide_in(tutorial_step: MarginContainer):
	tutorial_step.visible = true
	tutorial_step.position = offscreen_pos
	var tween = create_tween()
	tween.tween_property(tutorial_step, "position", start_pos, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await tween.finished
	
func slide_out(tutorial_step: MarginContainer):
	var tween = create_tween()
	tween.tween_property(tutorial_step, "position", offscreen_pos - Vector2(0, 100), 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tween.finished
	tutorial_step.visible = false

func _create_tween():
	if tween:
		tween.kill()
	tween = Tween.new()
