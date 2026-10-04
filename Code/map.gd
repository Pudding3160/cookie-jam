class_name Map extends Control

var current_room_type: Rooms.Room_Type
var map_buttons: Array[Map]

func set_current_room_type(room_type: Rooms.Room_Type) -> void:
	for button in map_buttons:
		if button.get_room_type() != room_type: 
			button.set_state(true);
			continue;
		button.set_state(false)
