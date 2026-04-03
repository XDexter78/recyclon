extends Area2D

var trash_type: String = "split"
var points: int = 10

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var original_parent: Node = null  # guardamos referencia al PathFollow2D

func _ready() -> void:
	input_pickable = true  # permite detectar toques sobre el Area2D

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			_start_drag(event.position)

func _input(event: InputEvent) -> void:
	if not is_dragging:
		return

	if event is InputEventScreenDrag:
		global_position = event.position + drag_offset

	elif event is InputEventScreenTouch:
		if not event.pressed:  # soltó el dedo
			_stop_drag()

func _start_drag(touch_pos: Vector2) -> void:
	is_dragging = true
	drag_offset = global_position - touch_pos

	# Despegar del PathFollow2D para moverlo libremente
	original_parent = get_parent()
	var current_global_pos = global_position
	var main = get_tree().root.get_node("Main")  # referencia ANTES de remover

	# Reparentar al nivel Main para que no siga la cinta
	original_parent.remove_child(self)
	main.add_child(self)
	global_position = current_global_pos

func _stop_drag() -> void:
	is_dragging = false
# Buscar si estamos sobre algún bote
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		if area.has_method("receive_trash"):
			area.receive_trash(self)
			return
	# No cayó en ningún bote, penalizar y eliminar
	queue_free()
