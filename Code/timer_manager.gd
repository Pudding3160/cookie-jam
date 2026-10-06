extends Node

var time := 320.0
var time_buffer: float;
var time_decrease_modifer := .1; 

func _ready() -> void:
	time_buffer = time;

func _process(delta: float) -> void:
	update_time(-delta * time_decrease_modifer);


func update_time(delta: float):
	time_buffer += delta;


func get_current_time() -> float:
	return time_buffer;

func get_time_modifier() -> float:
	return time_decrease_modifer;