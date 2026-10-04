class_name RoomManager extends Node

@export var start_room: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Instantiate the first room
	create_room(start_room)


func create_room(room: PackedScene) -> void:
	if (get_child_count() > 0): get_child(0).queue_free();
	var child = room.instantiate();
	add_child(child)
