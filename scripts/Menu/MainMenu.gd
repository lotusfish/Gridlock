extends Node2D

var wdOpen = false

func wardrobeOpen():
	$WardrobeAnim.visible = true
	$WardrobeAnim.play("default")
	wdOpen = true

func wardrobeClose():
	$WardrobeAnim.play("default",true)
	wdOpen = false


func _on_PLAY_pressed():
	get_tree().change_scene("res://class select.tscn")

func _on_SETTINGS_pressed():
	get_tree().change_scene("res://settings.tscn")

func _on_TUTORIAL_pressed():
	get_tree().change_scene("res://Tutorial.tscn")

func _on_CUSTOMISE_pressed():
	wardrobeOpen()

func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		if wdOpen == true:
			wardrobeClose()
