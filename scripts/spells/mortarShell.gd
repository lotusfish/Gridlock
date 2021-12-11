extends Area2D

func _ready():
	add_to_group("Bullet")
	add_to_group("BulletA")
	add_to_group("BulletB")

func _process(delta):
	position.y += 10
