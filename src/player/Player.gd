extends KinematicBody2D

onready var Bullet = preload("res://src/player/weapons/bullet.tscn")
onready var shotTimer = $ShotTimer

const MAX_SPEED:int = 150
const ACCELERATION:int = 2500
const FRICTION:int = 2500
const DASH_SPEED:int = 750
var velocity = Vector2.DOWN
var dash_vector:Vector2 = Vector2.DOWN
var just_shot = false
var wpn_energy = 10

enum{
	MOVE,
	DASH
}

var state = MOVE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state(delta)
		DASH:
			dash_state(delta)
	
	
func move_state(delta):
	print('velocity:',velocity)
	var input_vector:Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		dash_vector = input_vector
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("shoot"):
		if just_shot == false and wpn_energy > 0:
			just_shot = true
			spawn_bullet()
	if Input.is_action_just_pressed("dash"):
		state = DASH
		
func dash_state(delta):
	velocity = dash_vector * DASH_SPEED
	print(dash_vector)
	state = MOVE
	
	
func spawn_bullet():
	wpn_energy -= 1
	var b = Bullet.instance()
	b.position = position
	get_parent().add_child(b)
	shotTimer.start(0.25)


func _on_ShotTimer_timeout() -> void:
	just_shot = false


func _on_WpnTimer_timeout() -> void:
	if wpn_energy < 10:
		wpn_energy += 1
