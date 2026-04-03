extends Node2D

@export var speed: float = 100.0  # pixeles por segundo
var base_speed: float  # para calcular la proporción de animación

@onready var path: Path2D = $Path2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	base_speed = speed  # guardamos la velocidad inicial como referencia
	anim.play("default")

func _process(delta: float) -> void:
	# Sincronizar velocidad de animación con la velocidad actual
	anim.speed_scale = speed / base_speed

	for follower in path.get_children():
		if follower is PathFollow2D:
			follower.progress += speed * delta
			if follower.progress_ratio >= 1.0:
				_on_trash_reached_end(follower)

func _on_trash_reached_end(follower: PathFollow2D) -> void:
	follower.queue_free()
