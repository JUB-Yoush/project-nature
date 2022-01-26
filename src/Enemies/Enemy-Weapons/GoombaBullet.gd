extends Area2D


var speed = 2
var shot_velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += shot_velocity * speed * delta
	


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
