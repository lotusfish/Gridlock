extends Node

var skins = ["res://icon.png","res://art/skins/tinkerer_skin.png","res://icon.png"]
var shootingSkins = ["res://icon.png","res://art/skins/tinkerer_shooting.png","icon.png"]

enum classes{
	artificer = 1
	tinkerer = 2
	trapper = 3
}

var classA = classes.artificer
var classB = classes.artificer

func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		if get_tree().get_current_scene().get_name() != "Menu":
			get_tree().change_scene("res://Menu.tscn")
