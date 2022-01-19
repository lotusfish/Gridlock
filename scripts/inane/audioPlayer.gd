extends Node2D

var music = [
	[
		preload("res://sound/music/menuTheme.mp3")
	], #menu themes
	[
		preload("res://sound/music/battleTheme.mp3"),
		preload("res://sound/music/battle2b.mp3"),
		preload("res://sound/music/battle2a.mp3"),
		preload("res://sound/music/battle3.mp3")
	] #battle themes
]

func _ready():
	randomize()

func _process(delta):
	if get_tree().get_current_scene().get_name() == "Arena":
		if $battle.playing == false:
			$battle.stream = music[1][randi() % music[1].size()]
			$menu.playing = false
			$battle.playing = true
	else:
		if $menu.playing == false:
			$battle.playing = false
			$menu.playing = true
