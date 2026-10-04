extends Node

var time := 320.0
var time_buffer;

func _ready() -> void:
	time_buffer = time;

func _process(delta: float) -> void:
	update_time(delta);


func update_time(delta: float):
	time_buffer -= delta;
