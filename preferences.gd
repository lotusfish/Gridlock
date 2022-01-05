extends Node

var skins = [
	["res://art/skins/artificer_skin.png","res://art/skins/artificer_shooting.png"], #artificer
	["res://art/skins/tinkerer_skin.png","res://art/skins/tinkerer_shooting.png"], #tinkerer
	["res://art/skins/hunter_skin.png","res://art/skins/hunter_shooting.png"] #hunter
]

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
