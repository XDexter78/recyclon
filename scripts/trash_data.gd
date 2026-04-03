class_name TrashData
extends Resource

@export var name: String = ""
@export var trash_type: String = "organic"  # organic, recyclable, landfill, bags, split
@export var points: int = 10
@export var animation_name: String = "default"

# Solo para objetos tipo split: qué 2 objetos genera al separarse
@export var split_result_1: TrashData = null
@export var split_result_2: TrashData = null
