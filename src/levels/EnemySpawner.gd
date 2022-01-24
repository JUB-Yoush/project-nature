extends Node2D

onready var GoombaScene = preload("res://src/Enemies/Goomba.tscn")


func spawn_enemy(enemyStr,enemyPos):
	var EnemyScene = null
	if enemyStr == 'goomba':
		EnemyScene = GoombaScene
	var enemy = EnemyScene.instance()
	enemy.position = enemyPos.position
	get_parent().add_child(enemy)
	
		
	
