extends KinematicBody2D

onready var EBullet = preload("res://src/Enemies/Enemy-Weapons/GoombaBullet.tscn")
onready var shotTimer = $shotTimer
var speed:int = 125
var velocity:Vector2 = Vector2.DOWN
var player_pos = Vector2.ZERO
var shot_velocity = Vector2.ZERO
var shot_count = 0


signal request_player_pos(enemy)
func _ready() -> void:
	connect('request_player_pos', get_parent(), "on_player_pos_requested")
	pass # Replace with function body.



func _process(delta: float) -> void:
	move_and_slide(velocity * speed)




func _on_shotTimer_timeout() -> void:
	shot_count += 1
	fire_shot()

func fire_shot():
	emit_signal("request_player_pos",self)
	shot_velocity = position.direction_to(player_pos) * speed
	var eBullet = EBullet.instance()
	eBullet.position = position
	eBullet.shot_velocity = shot_velocity
	get_parent().add_child(eBullet)
	if shot_count < 3:
		shotTimer.start(0.5)
	
	
	
	


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
