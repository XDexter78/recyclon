extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var error_label: Label = $ErrorLabel

var score: int = 0
var errors: int = 0

func add_score(points: int) -> void:
	score += points
	score_label.text = "Puntos: " + str(score)

func add_error() -> void:
	errors += 1
	error_label.text = "Errores: " + str(errors)
