extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var globals = get_node("/root/preferences")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClassSelectA_item_selected(index):
	if index != 0:
		globals.classA = index
	pass # Replace with function body.


func _on_ClassSelectB_item_selected(index):
	if index != 0:
		globals.classB = index
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://Arena.tscn")
	pass # Replace with function body.
