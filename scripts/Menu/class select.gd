extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var globals = get_node("res://preferences.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClassSelectA_item_selected(index):
	print(index)
	pass # Replace with function body.


func _on_ClassSelectB_item_selected(index):
	print(index)
	pass # Replace with function body.
