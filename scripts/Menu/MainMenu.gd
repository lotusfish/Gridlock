extends Node2D


func _on_PLAY_pressed():
	get_tree().change_scene("res://class select.tscn")

func _on_SETTINGS_pressed():
	get_tree().change_scene("res://settings.tscn")

func _on_TUTORIAL_pressed():
	get_tree().change_scene("res://Tutorial.tscn")

func _on_CUSTOMISE_pressed():
	pass # Replace with function body.
