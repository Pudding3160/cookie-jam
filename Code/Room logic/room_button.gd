extends Button

@export var room: PackedScene

func _on_pressed() -> void:
	var manager = get_node("/root/IanTestRoom/RoomManager")
	if (!manager): return;
	var room_manager = manager as RoomManager;
	if (!room_manager): return;
	room_manager.create_room(room);
