extends Area2D
signal hit
signal paralyze
var bullet
export(int) var AOrB
func _ready():
	pass

func _process(delta):
	if get_owner() != null:
		if AOrB == 1:
			bullet = get_tree().get_nodes_in_group("BulletB")
		if AOrB == 2:
			bullet = get_tree().get_nodes_in_group("BulletA")
	var trapss = get_tree().get_nodes_in_group("traps")
	if bullet != null:
		for i in range(len(bullet)):
			if overlaps_area(bullet[i]) == true:
				bullet[i].queue_free()
				emit_signal("hit")
	if trapss != null:
		for i in range(len(trapss)):
			if overlaps_area(trapss[i]) == true:
				if trapss[i].is_in_group("paralyzer"):
					emit_signal("paralyze")
