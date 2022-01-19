extends KinematicBody2D

onready var Bullet = preload("res://src/weapons/bullet.tscn")

const MAX_SPEED:int = 150
const ACCELERATION:int = 1250
const FRICTION:int = 1500
var velocity = Vector2.DOWN


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var input_vector:Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("shoot"):
		spawn_bullet()

func spawn_bullet():
	var b = Bullet.instance()
	b.position = position
	get_parent().add_child(b)
