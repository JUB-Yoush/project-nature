extends KinematicBody2D

var speed:int = 50
var velocity:Vector2 = Vector2.DOWN
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	move_and_slide(velocity * speed)
