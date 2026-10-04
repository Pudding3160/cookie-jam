class_name MapButton extends Button

@export var room: PackedScene
@export var room_manager_string: String
@export var room_type: Rooms.Room_Type
var room_manager: RoomManager

func _ready() -> void:
	room_manager = get_node(room_manager_string)

func _on_pressed() -> void:
	if (room_manager == null): 
		printerr(self.to_string() + " couldn't find a reference to the scene's room manager :(");
		return;
	
	room_manager.create_room(room, room_type);

func get_room_type() -> Rooms.Room_Type:
	return room_type;


func set_state(is_active: bool):
	disabled = !is_active;
