extends Node2D

onready var player = $Player
onready var enemySpawner = $EnemySpawner
onready var enemyPositions = $EnemyPositions
onready var spawn_array = enemyPositions.get_children()
onready var eventTimer = $EventTimer
var event_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eventTimer.start(1)
	





func _on_EventTimer_timeout() -> void:
	event_time += 1
	check_events(event_time)
	print(event_time)
	eventTimer.start(1)


func check_events(event_time):
	if event_time == 2:
		event_spawn('goomba')

func event_spawn(spawn_str):
	if spawn_str == 'goomba':
		var spawnPos = spawn_array[randi() % spawn_array.size()]
		enemySpawner.spawn_enemy('goomba',spawnPos)
