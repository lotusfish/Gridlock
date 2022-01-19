extends Node2D

var prog = 0
var heldScores = [0,0]
var gotScores = false

func _ready():
	pass

func _process(delta):
	prog += 1 * delta
	if prog > 1:
		$RadialProgressBar.progress -= 1
		prog = 0
	
	if $RadialProgressBar.progress < 1:
		$PostGame/CanvasLayer/Control.visible = true
		if !gotScores:
			heldScores[0] = get_node("Text scores/ScoreA").hits
			heldScores[1] = get_node("Text scores/ScoreB").hits
			gotScores = true
		if heldScores[0] > heldScores[1]:
			$PostGame/CanvasLayer/Control/Label1.text = "PLAYER A WINS!"
		elif heldScores[0] < heldScores[1]:
			$PostGame/CanvasLayer/Control/Label1.text = "PLAYER B WINS!"
		
		$PostGame/CanvasLayer/Control/Label2.text = "THE FINAL SCORE WAS : " +  str(heldScores[0]) + " TO " + str(heldScores[1])

		
