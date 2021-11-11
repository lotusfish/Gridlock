extends Node2D



var active = false
var t = 0
var bulletA = preload("res://playersandbullets/bullet_a.tscn")
var bulletB = preload("res://playersandbullets/bullet_b.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(1).connect("timeout",self,"beginFiring")
	pass # Replace with function body.

func beginFiring():
	active = true
	get_tree().create_timer(6).connect("timeout",self,"endFiring")
	
func endFiring():
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += 1
	if t > 10 and active == true:
		var bulA = bulletA.instance()
		var bulB = bulletB.instance()
		bulA.global_position = global_position
		bulB.global_position = global_position
		get_node("..").add_child(bulA)
		get_node("..").add_child(bulB)
		t = 0
	pass
