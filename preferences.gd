extends Node

var heads = ["res://player parts/head/head_dino.png","res://player parts/head/head_ninja.png"]
var bodies = ["res://player parts/torso/body_dino.png","res://player parts/body/body_ninja.png"]

enum cosmetics{
	dino = 1
	ninja = 2
}

enum classes{
	artificer = 1
	tinkerer = 2
	trapper = 3
}

var headA = cosmetics.dino
var bodyA = cosmetics.dino
var headB = cosmetics.ninja
var bodyB = cosmetics.ninja

var classA = classes.artificer
var classB = classes.artificer

func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		if get_tree().get_current_scene().get_name() != "Menu":
			get_tree().change_scene("res://Menu.tscn")
