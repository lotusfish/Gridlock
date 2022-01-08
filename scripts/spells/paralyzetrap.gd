extends Area2D
var active = true
func _ready():
	pass

func deactivate():
	queue_free()

func trigger():
	active = false
	get_tree().create_timer(1).connect("timeout",self,"deactivate")
	$AnimatedSprite.playing = true

func _on_Area2D_body_entered(body:Node):
	if active:
		if body.has_method("paralyze"):
			body.paralyze(1)
			trigger()
