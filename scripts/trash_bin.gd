extends Area2D

@export var bin_type: String = "organic"  # tipo de este bote

signal correct_choice(points: int)
signal wrong_choice()
signal split_requested(trash_item: Area2D)

func receive_trash(trash: Area2D) -> void:
	if trash.trash_type == "split":
		split_requested.emit(trash)
	elif trash.trash_type == bin_type:
		correct_choice.emit(trash.points)
	else:
		wrong_choice.emit()
	trash.queue_free()
