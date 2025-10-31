extends Control


var firstDownloadOpen = true
var installWindow
var terminalSequence
var horsePlayerInstalled = false
var missingInstall
var gameCaptcha
var gameCaptchaDone = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	installWindow = load("res://install_popup.tscn")
	terminalSequence = load("res://terminal_sequence.tscn")
	missingInstall = load("res://missing_install_notif.tscn")
	gameCaptcha = load("res://game_captcha.tscn")
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tab_1_button_pressed() -> void:
	playClick()
	$DownloadPage.hide()
	$GamePage.show()
	$Tab1.modulate = Color.WHITE
	$Tab2.modulate = Color.GRAY
	


func _on_tab_2_button_pressed() -> void:
	playClick()
	$GamePage.hide()
	$DownloadPage.show()
	$Tab1.modulate = Color.GRAY
	$Tab2.modulate = Color.WHITE
	pass # Replace with function body.
	

func finishDownloadSequence():
	var newInstallWindow = installWindow.instantiate()
	add_child(newInstallWindow)
	pass

func openTerminal():
	var newTerminalSequence = terminalSequence.instantiate()
	add_child(newTerminalSequence)
	pass
	
func backToGamePage():
	horsePlayerInstalled = true
	$DownloadPage.hide()
	$GamePage.show()


func _on_play_game_pressed() -> void:
	playClick()
	if !horsePlayerInstalled:
		var newMissingInstall = missingInstall.instantiate()
		add_child(newMissingInstall)
	elif !gameCaptchaDone:
		var newGameCaptcha = gameCaptcha.instantiate()
		add_child(newGameCaptcha)
	pass # Replace with function body.
	
func openTab():
	$Tab2Button.show()
	$Tab2.show()
	
	
func finishGameCaptcha():
	gameCaptchaDone = true
	$GamePage/PlayGame.hide()
	$GamePage/TextureRect2.hide()
	openGame()
	pass

func openGame():
	$AudioStreamPlayer.stop()
	$HorseTheme.play()
	$GamePage/PlayGame.hide()
	$GamePage/TextureRect2.hide()
	$HorseGame.show()
	pass

func playClick():
	var track = randi_range(1, 4)
	$Click.stream = load("res://Art/Click" + str(track) + ".wav")
	$Click.play()
