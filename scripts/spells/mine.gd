extends Area2D
var speed = 0
func _ready():
	add_to_group("BulletA")
	add_to_group("BulletB")
	add_to_group("Bullet")
	pass
	
func _process(delta):
	position.x += speed * delta
	if position.x > 1280:
		queue_free()
	pass
