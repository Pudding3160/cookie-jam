class_name DragObject extends Node2D

var is_dragged := true;
var is_scanned := false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !is_dragged: return;
	var offset = get_offset();
	global_position = get_global_mouse_position();


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is not InputEventMouseButton: return;
	if event.is_pressed(): is_dragged = true;
	else: is_dragged = false;


func get_offset() -> Vector2:
	return get_global_mouse_position() - global_position;
