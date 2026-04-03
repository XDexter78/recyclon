extends Node

@export var trash_scene: PackedScene = preload("res://scenes/trashItem.tscn")
@onready var conveyor_path: Path2D = get_parent().get_node("Conveyor/Path2D")

# Llama esto cuando un objeto split llega al bote correcto
func split_into_two(original_trash: Area2D) -> void:
	# Definir los 2 objetos resultantes del split
	var new_types = _get_split_results(original_trash)

	for type_data in new_types:
		var trash = trash_scene.instantiate()
		trash.trash_type = type_data.type
		trash.points = type_data.points

		var follower = PathFollow2D.new()
		follower.progress = 0.0
		follower.rotates = false
		follower.loop = false
		conveyor_path.add_child(follower)
		follower.add_child(trash)

func _get_split_results(_trash: Area2D) -> Array:
	# Por ahora retorna 2 tipos aleatorios
	# Después puedes definir esto por cada objeto split
	var possible_types = ["organic", "recyclable", "landfill", "bags"]
	var type1 = possible_types.pick_random()
	var type2 = possible_types.pick_random()

	return [
		{ "type": type1, "points": 10 },
		{ "type": type2, "points": 10 }
	]
