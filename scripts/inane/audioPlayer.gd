extends Node2D



func _process(delta):
	if get_tree().get_current_scene().get_name() == "Arena":
		if $battle.playing == false:
			$menu.playing = false
			$battle.playing = true
	else:
		if $menu.playing == false:
			$battle.playing = false
			$menu.playing = true
