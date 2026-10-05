extends Node

var time := 320.0
var time_buffer;
var time_decrease_modifer := 0.1; 

func _ready() -> void:
	time_buffer = time;

func _process(delta: float) -> void:
	update_time(delta * time_decrease_modifer);


func update_time(delta: float):
	time_buffer -= delta;
