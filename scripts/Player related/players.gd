extends KinematicBody2D

#region notes to myself

#Note to future me:
#	When creating abilities:
#		Add it to the abilities enum
#		Add it to the cooldown match cases in ready
#		Write the ability function
#		Add it to cast()

#endregion

#region basic variables
var gridx = 2 #Current grid position
var gridy = 2 #^^^^
var gridjump = 48 #Distance between grid squares
var hp = 3 # Starting HP
var invuln = false #Am i currently invulnerable
var weaponCooledDown = true #Can i shoot?
var mobile = true#Can i move?
var paralyzed = false # am i banned from moving ;(
var movementCD = 0.075#Cooldown between movements
var baseMoveCD = movementCD
onready var globals = get_node("/root/preferences")#Where global variables and stuff are stored
export(int) var AorB #Which player 1:A 2:B
export(PackedScene) var myBullet # What's my bullet scene
export(NodePath) var myEnemy #the other enemy
#endregion

#region enums
enum dirs{
	up = 1
	left = 2
	down = 3
	right = 4
}
enum abilities{
	#generic class
	burstShot = 1
	zapEnemy = 2
	shield = 3
	#engineer class
	barrier = 4
	beamTurret = 5
	mine = 6 # this ability has since been removed from the game but is left in code just in case. don't re-use unless necesarry
	mortar = 7
	#hunter class
	paratrap = 8
	slowtrap = 9
	damagetrap = 10
}
#endregion

#region vars that should be overwritten at game start

var abilityA = abilities.burstShot
var abilityB = abilities.zapEnemy
var abilityC = abilities.shield
var myAbilities = [abilities.burstShot, abilities.zapEnemy, abilities.shield]
var aCooledDown = true
var bCooledDown = true
var cCooledDown = true
var aCD = 3
var bCD = 3
var cCD = 3
var cd = [200,200,200]
var myClass = 1
var myIdleAnim
var myShotAnim
#endregion

#region signals
signal Ahurt
signal Adead
signal Ashot
signal Amove(dir)
signal Bhurt
signal Bdead
signal Bshot
signal Bmove(dir)
signal startCooldown(cd,slot)

#endregion

#region general player funcs

func move(dir):
	if dir == dirs.up:
		gridy -= 1
		position.y -= gridjump
	if dir == dirs.left:
		gridx -= 1
		position.x -= gridjump
	if dir == dirs.down:
		gridy += 1
		position.y += gridjump
	if dir == dirs.right:
		gridx += 1
		position.x += gridjump
	if AorB == 1:
		emit_signal("Amove",dir)
	else:
		emit_signal("Bmove",dir)
	get_tree().create_timer(movementCD).connect("timeout",self,"movementCooled")
	mobile = false

func hurt(dmg:float = 1):
	hp -= 1
	if AorB == 1:
		emit_signal("Ahurt")
	elif AorB == 2:
		emit_signal("Bhurt")

#exposing more variables to other nodes
func setMoveCD(newValue):
	movementCD = newValue

func paralyze(duration):
	paralyzed = true
	mobile = false
	get_tree().create_timer(duration).connect("timeout",self,"endparalyze")

func endparalyze():
	paralyzed = false
	mobile = true

func slow(duration,factor):
	self.movementCD *= factor
	get_tree().create_timer(duration).connect("timeout",self,"endSlow")

func endSlow():
	self.movementCD = baseMoveCD

#endregion

#region abilityfuncs

func shoot():
	$Sprite.texture = myShotAnim
	var shot = myBullet.instance()
	owner.add_child(shot)
	shot.position = position
	if AorB == 1:
		emit_signal("Ashot")
	elif AorB == 2:
		emit_signal("Bshot")
	pass


func abilityBurstShot():
	var shotA = myBullet.instance()
	var shotB = myBullet.instance()
	var shotC = myBullet.instance()
	owner.add_child(shotA)
	owner.add_child(shotB)
	owner.add_child(shotC)
	var above = Vector2(position.x,position.y - 48)
	var below = Vector2(position.x,position.y + 48)
	shotA.position = above
	shotB.position = position
	shotC.position = below
func abiltyZapEnemy():
	var enemy = get_node(myEnemy)
	var boltscene = preload("res://spell scenes/zapspell.tscn")
	var bolt = boltscene.instance()
	#remove_child(bolt)
	var root = get_node("..")
	root.add_child(bolt)
	if AorB == 1:
		var crosshair = get_node("../CrosshairA")
		bolt.global_position = crosshair.global_position
	else:
		var crosshair = get_node("../CrosshairB")
		bolt.global_position = crosshair.global_position
	if enemy.gridx == gridx and enemy.gridy == gridy:
		if enemy.invuln == false:
			enemy.hurt()
			#enemy.hp -= 1
			#if AorB == 1:
				#enemy.emit_signal("Bhurt")
			#else:
				#enemy.emit_signal("Ahurt")
	pass
func abilityShield():
	invuln = true
	get_tree().create_timer(0.6).connect("timeout",self,"abilityShieldEnd")
	$Sprites/head.modulate = Color(0,0,1)
	$Sprites/body.modulate = Color(0,0,1)
func abilityShieldEnd():
	invuln = false
	$Sprites/head.modulate = Color(1,1,1)
	$Sprites/body.modulate = Color(1,1,1)
func abilityBarrier():
	var barrier = preload("res://spell scenes/shield.tscn")
	var myBarrier = barrier.instance()
	var root = get_node("..")
	#remove_child(myBarrier)
	root.add_child(myBarrier)
	if AorB == 1:
		myBarrier.global_position.x = position.x + 56
		myBarrier.global_position.y = position.y
	if AorB == 2:
		myBarrier.global_position.x = position.x - 56
		myBarrier.global_position.y = position.y
	pass
func abilityTurret():
	var turret = load("res://spell scenes/turret.tscn")
	var tur = turret.instance()
	owner.add_child(tur)
	tur.position = global_position
func abilityMine():
	var mine = load("res://spell scenes/mine.tscn")
	var tur = mine.instance()
	owner.add_child(tur)
	if AorB == 1:
		tur.position = get_node("../CrosshairA").global_position
	elif AorB == 2:
		tur.position = get_node("../CrosshairB").global_position
func abilityMortar():
	var mortar = load("res://spell scenes/mortar.tscn")
	var inst = mortar.instance()
	owner.add_child(inst)
	inst.position = global_position
	if AorB == 2:
		inst.scale.x = -1
	inst.AorB = AorB
func abilityParalyzerTrap():
	var mine = load("res://spell scenes/paratrap.tscn")
	var tur = mine.instance()
	owner.add_child(tur)
	if AorB == 1:
		tur.position = get_node("../CrosshairA").global_position
	elif AorB == 2:
		tur.position = get_node("../CrosshairB").global_position
func abilitySlowerTrap():
	var mine = load("res://spell scenes/slowtrap.tscn")
	var tur = mine.instance()
	owner.add_child(tur)
	if AorB == 1:
		tur.position = get_node("../CrosshairA").global_position
	elif AorB == 2:
		tur.position = get_node("../CrosshairB").global_position
func abilityDamageTrap():
	var mine = load("res://spell scenes/hurttrap.tscn")
	var tur = mine.instance()
	owner.add_child(tur)
	if AorB == 1:
		tur.position = get_node("../CrosshairA").global_position
	elif AorB == 2:
		tur.position = get_node("../CrosshairB").global_position

	#function that casts abilities
func cast(ability):
	if ability == abilities.burstShot:
		abilityBurstShot()
	elif ability == abilities.zapEnemy:
		abiltyZapEnemy()
	elif ability == abilities.shield:
		abilityShield()
	elif ability == abilities.barrier:
		abilityBarrier()
	elif ability == abilities.beamTurret:
		abilityTurret()
	elif ability == abilities.mine:
		abilityMine()
	elif ability == abilities.mortar:
		abilityMortar()
	elif ability == abilities.paratrap:
		abilityParalyzerTrap()
	elif ability == abilities.slowtrap:
		abilitySlowerTrap()
	elif ability == abilities.damagetrap:
		abilityDamageTrap()
	else:
		print("Invalid ability cast")

#endregion

#region cooldownfuncs
func aCooled():
	aCooledDown = true
func bCooled():
	bCooledDown = true
func cCooled():
	cCooledDown = true
func weaponCooled():
	weaponCooledDown = true
	$Sprite.texture = myIdleAnim
func movementCooled():
	if paralyzed == false:
		mobile = true
#endregion

#region editor callbacks
func _ready():
	#get which class i am according to preferences.gd
	match AorB:
		1:
			myClass = globals.classA
		2:
			myClass = globals.classB
	#define my sprites
	myIdleAnim = load(globals.skins[myClass-1][0])
	myShotAnim = load(globals.skins[myClass-1][1])
	$Sprite.texture = myIdleAnim
	if AorB == 2:
		$Sprite.scale.x = -1
	#Define which abilities are tied to your class
	match myClass:
		1: # artificer
			myAbilities[0] = abilities.burstShot
			myAbilities[1] = abilities.zapEnemy
			myAbilities[2] = abilities.shield
		2: # tinkerer
			myAbilities[0] = abilities.beamTurret
			myAbilities[1] = abilities.mortar
			myAbilities[2] = abilities.barrier
		3: # trapper
			myAbilities[0] = abilities.paratrap
			myAbilities[1] = abilities.slowtrap
			myAbilities[2] = abilities.damagetrap

	#Define your cooldowns based on what's stored in your ability variables.
	for i in range(3):
		match myAbilities[i]:
			1:
				cd[i] = 3
			2:
				cd[i] = 3
			3:
				cd[i] = 4
			4:
				cd[i] = 14
			5:
				cd[i] = 14
			6:
				cd[i] = 8 	
			7:
				cd[i] = 15
	#Set up signals for cooldowns
	if AorB == 1:
		connect("startCooldown",get_node("../CDI/ACD1"),"startCooldown")
		connect("startCooldown",get_node("../CDI/ACD2"),"startCooldown")
		connect("startCooldown",get_node("../CDI/ACD3"),"startCooldown")
	elif AorB == 2:
		connect("startCooldown",get_node("../CDI/BCD1"),"startCooldown")
		connect("startCooldown",get_node("../CDI/BCD2"),"startCooldown")
		connect("startCooldown",get_node("../CDI/BCD3"),"startCooldown")

	pass 

func _input(event):
	if AorB == 1:
		if mobile == true:
			if event.is_action_pressed("A_UP"):
				if gridy > 0:
					move(dirs.up)
			if event.is_action_pressed("A_DOWN"):
				if gridy < 4:
					move(dirs.down)
					
			if event.is_action_pressed("A_LEFT"):
				if gridx > 0:
					move(dirs.left)
					
			if event.is_action_pressed("A_RIGHT"):
				if gridx < 4:
					move(dirs.right)
					
		if event.is_action_pressed("A_SHOOT") and weaponCooledDown == true:
			shoot()
			weaponCooledDown = false
			get_tree().create_timer(0.25).connect("timeout",self,"weaponCooled")
			
		if event.is_action_pressed("A_ABIL1") and aCooledDown:
			cast(myAbilities[0])
			aCooledDown = false
			get_tree().create_timer(cd[0]).connect("timeout",self,"aCooled")
			emit_signal("startCooldown",cd[0],1)
			
		if event.is_action_pressed("A_ABIL2") and bCooledDown:
			cast(myAbilities[1])
			bCooledDown = false
			get_tree().create_timer(cd[1]).connect("timeout",self,"bCooled")
			emit_signal("startCooldown",cd[1],2)
			
		if event.is_action_pressed("A_ABIL3") and cCooledDown:
			cast(myAbilities[2])
			cCooledDown = false
			get_tree().create_timer(cd[2]).connect("timeout",self,"cCooled")
			emit_signal("startCooldown",cd[2],3)

	elif AorB == 2:
		if mobile == true:
			if event.is_action_pressed("B_UP"):
				if gridy > 0:
					move(dirs.up)
					
			if event.is_action_pressed("B_DOWN"):
				if gridy < 4:
					move(dirs.down)
					
			if event.is_action_pressed("B_LEFT"):
				if gridx > 0:
					move(dirs.left)
					
			if event.is_action_pressed("B_RIGHT"):
				if gridx < 4:
					move(dirs.right)

		if event.is_action_pressed("B_SHOOT") and weaponCooledDown == true:
			weaponCooledDown = false
			get_tree().create_timer(0.25).connect("timeout",self,"weaponCooled")
			shoot()

		if event.is_action_pressed("B_ABIL1") and aCooledDown:
			cast(myAbilities[0])
			aCooledDown = false
			get_tree().create_timer(cd[0]).connect("timeout",self,"aCooled")
			emit_signal("startCooldown",cd[0],1)
			
		if event.is_action_pressed("B_ABIL2") and bCooledDown:
			cast(myAbilities[1])
			bCooledDown = false
			get_tree().create_timer(cd[1]).connect("timeout",self,"bCooled")
			emit_signal("startCooldown",cd[1],2)
			
		if event.is_action_pressed("B_ABIL3") and cCooledDown:
			cast(myAbilities[2])
			cCooledDown = false
			get_tree().create_timer(cd[2]).connect("timeout",self,"cCooled")
			emit_signal("startCooldown",cd[2],3)

func _process(delta):
	if hp == 0:
		if AorB == 1:
			emit_signal("Adead")
		elif AorB == 2:
			emit_signal("Bdead")


func _on_Area2D_hit():
	if invuln == false:
		hurt()
#endregion


