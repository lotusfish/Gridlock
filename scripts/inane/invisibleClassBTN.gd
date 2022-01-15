extends Button

export(int) var pTeam = 1
export(int) var pClass = 1
onready var globals = get_node("/root/preferences")


func _ready():
	connect("pressed",self,"onPressed")
	pass

func onPressed():
	match pTeam:
		1:
			globals.classA = pClass
		2:
			globals.classB = pClass
	emit(0.3)

func emit(duration):
	$CPUParticles2D.emitting = true
	get_tree().create_timer(duration).connect("timeout",self,"stopEmit")

func stopEmit():
	$CPUParticles2D.emitting = false