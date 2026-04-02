extends Node2D

@export var speed: float = 100.0  # pixeles por segundo

# Referencia al Path2D
@onready var path: Path2D = $Path2D

# Cada basura en la cinta se mueve con su PathFollow2D
func _process(delta: float) -> void:
	for follower in path.get_children():
		if follower is PathFollow2D:
			follower.progress += speed * delta
			# Si llegó al final de la cinta sin ser recogido
			if follower.progress_ratio >= 1.0:
				_on_trash_reached_end(follower)

func _on_trash_reached_end(follower: PathFollow2D) -> void:
	# Aquí emites señal de "vida perdida" o penalización
	follower.queue_free()
