extends Area2D

var speed = 300
var velocity = Vector2.UP


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += velocity * speed * delta
	
func _on_bullet_body_entered(body: Node) -> void:
	if body.is_in_group('enemies'):
		body.queue_free()
	queue_free()

