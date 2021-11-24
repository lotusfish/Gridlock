extends ProgressBar

export(int) var A_Or_B_Or_C
#export(int) var Team_A_Or_B
#export(NodePath) var PlayerA
#export(NodePath) var PlayerB

var timeLeft = 0

func _ready():
	pass

func startCooldown(cd,slot):
	if slot == A_Or_B_Or_C:
		max_value = cd
		timeLeft = cd
		
func _process(delta):
	timeLeft -= 1 * delta
	value = timeLeft
