extends Node2D

var targetPos = Vector2(0,0)
var active = false
var timeElapsed = 0
var AorB = 1
onready var bulletSCN = preload("res://spell scenes/mortarShell.tscn")

func activate():
    active = true


func _ready():
    
    get_tree().create_timer(0.8).connect("timeout",self,"activate")
    get_tree().create_timer(4).connect("timeout",self,"queue_free")

func _process(delta):
    if AorB == 1:
        targetPos = Vector2(global_position.x + 372, global_position.y - 400)
    else:
        targetPos = Vector2(global_position.x - 372, global_position.y - 400)
    if active == true:
        timeElapsed += delta
        if timeElapsed > 0.8:
            timeElapsed = 0
            var shot = bulletSCN.instance()
            add_child(shot)
            #shot.global_position = Vector2(global_position.x + 372,global_position.y - 400)
            shot.global_position = Vector2(targetPos)
            #+232 -400

