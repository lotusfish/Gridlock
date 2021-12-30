extends Node2D

var prog = 0
var heldScores = [0,0]


func _ready():
	pass

func _process(delta):
	prog += 1 * delta
	if prog > 1:
		$RadialProgressBar.progress -= 1
		prog = 0
	
	if $RadialProgressBar.progress < 1:
		$PostGame.visible = true
		heldScores[0] = get_node("Text scores/ScoreA").hits
		heldScores[1] = get_node("Text scores/ScoreB").hits
		if heldScores[0] > heldScores[1]:
			$PostGame/Label1.text = "PLAYER A WINS!"
		elif heldScores[0] < heldScores[1]:
			$PostGame/Label1.text = "PLAYER B WINS!"
		
		$PostGame/Label2.text = "THE FINAL SCORE WAS : " +  str(heldScores[0]) + " TO " + str(heldScores[1])

		
