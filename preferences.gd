extends Node

var heads = ["res://player parts/head/head_dino.png","res://player parts/head/head_ninja.png"]
var bodies = ["res://player parts/torso/body_dino.png","res://player parts/body/body_ninja.png"]

enum cosmetics{
	dino = 1
	ninja = 2
}

enum classes{
	generic = 1
	barrierer = 2
}

var headA = cosmetics.dino
var bodyA = cosmetics.dino
var headB = cosmetics.ninja
var bodyB = cosmetics.ninja

var classA = classes.barrierer
var classB = classes.barrierer

