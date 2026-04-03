extends Node

@export var trash_scene: PackedScene = preload("res://scenes/trashItem.tscn")  # Arrastra TrashItem.tscn aquí en el inspector
@export var spawn_interval: float = 4.0  # segundos entre cada spawn
@export var min_interval: float = 0.7    # intervalo mínimo (dificultad máxima)
@export var difficulty_rate: float = 0.02 # cuánto se reduce el intervalo cada spawn

@onready var timer: Timer = $SpawnTimer
@onready var conveyor: Node2D = get_parent().get_node("Conveyor")

func _ready() -> void:
	timer.wait_time = spawn_interval
	timer.timeout.connect(_on_spawn_timer_timeout)
	timer.start()

func _on_spawn_timer_timeout() -> void:
	_spawn_trash()
	_increase_difficulty()

func _spawn_trash() -> void:
	var trash = trash_scene.instantiate()
	# Crear un PathFollow2D para montarlo en la cinta
	var follower = PathFollow2D.new()
	follower.progress = 0.0
	follower.rotates = false
	follower.loop = false
	conveyor.get_node("Path2D").add_child(follower)
	follower.add_child(trash)

func _increase_difficulty() -> void:
	spawn_interval = max(min_interval, spawn_interval - difficulty_rate)
	timer.wait_time = spawn_interval
