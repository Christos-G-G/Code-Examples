extends Control

@onready var start_select = $MenuContainer/TitleScreenContainer/OptionsContainer/ArrowContainer/HBoxContainer/StartArrow
@onready var credits_select = $MenuContainer/TitleScreenContainer/OptionsContainer/ArrowContainer/HBoxContainer2/CreditsArrow
@onready var exit_select = $MenuContainer/TitleScreenContainer/OptionsContainer/ArrowContainer/HBoxContainer3/ExitArrow

@onready var start_button = $MenuContainer/TitleScreenContainer/OptionsContainer/ButtonContainer/StartContainer/StartButton
@onready var credits_button = $MenuContainer/TitleScreenContainer/OptionsContainer/ButtonContainer/CreditsContainer/CreditsButton
@onready var exit_button = $MenuContainer/TitleScreenContainer/OptionsContainer/ButtonContainer/ExitContainer/ExitButton

@onready var credits_scene = $MenuContainer/CreditsBG
@onready var back_button = $MenuContainer/CreditsBG/BackButton

func _ready():
	start_select.visible = false
	credits_select.visible = false
	exit_select.visible = false
	credits_scene.visible = false
	
	start_button.connect("mouse_entered", Callable(self, "_on_start_button_mouse_entered"))
	start_button.connect("mouse_exited", Callable(self, "_on_start_button_mouse_exited"))
	
	credits_button.connect("mouse_entered", Callable(self, "_on_credits_button_mouse_entered"))
	credits_button.connect("mouse_exited", Callable(self, "_on_credits_button_mouse_exited"))
	
	exit_button.connect("mouse_entered", Callable(self, "_on_exit_button_mouse_entered"))
	exit_button.connect("mouse_exited", Callable(self, "_on_exit_button_mouse_exited"))
	
	credits_button.connect("pressed", Callable(self, "_on_credits_button_pressed"))
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	

func _on_start_button_mouse_entered():
	start_select.visible = true


func _on_start_button_mouse_exited():
	start_select.visible = false


func _on_credits_button_mouse_entered():
	credits_select.visible = true


func _on_credits_button_mouse_exited():
	credits_select.visible = false


func _on_exit_button_mouse_entered():
	exit_select.visible = true


func _on_exit_button_mouse_exited():
	exit_select.visible = false
	

func _on_start_button_pressed():
	var game_scene_path = "res://world.tscn"
	get_tree().change_scene_to_file(game_scene_path)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	credits_scene.visible = true

func _on_back_button_pressed():
	credits_scene.visible = false
