extends KinematicBody2D

onready var Bullet = preload("res://src/player/weapons/bullet.tscn")
onready var shotTimer = $ShotTimer
onready var animPlayer = $AnimationPlayer

const MAX_SPEED:int = 150
const ACCELERATION:int = 2500
const FRICTION:int = 2500
const DASH_SPEED:int = 750

var velocity = Vector2.DOWN
var dash_vector:Vector2 = Vector2.UP

var just_shot = false
var in_parry = false
var wpn_energy = 10
var dash_energy = 3

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
	var input_vector:Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		dash_vector = input_vector
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
		dash_vector = Vector2.ZERO
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("shoot"):
		if just_shot == false and wpn_energy > 0:
			just_shot = true
			spawn_bullet()
	if Input.is_action_just_pressed("dash") and dash_vector != Vector2.ZERO:
		state = DASH
	if Input.is_action_just_pressed("parry") and in_parry == false:
		parry()
		
		
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

func parry():
	in_parry = true
	animPlayer.play("parry_spin")
	$ParryArea/CollisionShape2D.disabled == false

func on_parry_animation_ended():
	$ParryArea/CollisionShape2D.disabled == true
	in_parry = false
	
