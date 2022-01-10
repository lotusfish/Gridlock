extends Area2D
var active = true
export(int) var type = 1
#1=parlayze
#2=hurt
#3=slow
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
		match type:
			1:
				if body.has_method("paralyze"):
					body.paralyze(1)
					trigger()
			2:
				if body.has_method("hurt"):
					body.hurt(1)
					trigger()
			3:
				if body.has_method("slow"):
					body.slow(4,4)
					trigger()
