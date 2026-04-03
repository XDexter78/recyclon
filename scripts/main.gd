extends Node2D

@onready var split_bin = $Bins/SplitBin
@onready var split_manager = $SplitManager
@onready var hud = $HUD

func _ready() -> void:
	# Conectar cada bote al HUD
	for bin in $Bins.get_children():
		bin.correct_choice.connect(_on_correct)
		bin.wrong_choice.connect(_on_wrong)

	split_bin.split_requested.connect(_on_split_requested)

func _on_correct(points: int) -> void:
	hud.add_score(points)

func _on_wrong() -> void:
	hud.add_error()

func _on_split_requested(trash_item: Area2D) -> void:
	split_manager.split_into_two(trash_item)
