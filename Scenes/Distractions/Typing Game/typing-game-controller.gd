class_name EmailController extends DistractionControllerBase
func getdiff()->void: 
	difficulty=DifficultyManager.diffemail
func _ready() -> void:
	interval_buffer = interval;
	var node := get_node("/root/Main/RoomManager");
	if (node != null): room_manager = node as RoomManager;
	getdiff()
	print(difficulty)
