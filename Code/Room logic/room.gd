class_name Room extends Node2D



#@export var has_task := true;
#@export var cooldown: float;
#@export var rand_add_range: Vector2;
#var cooldown_buffer: float;
#@export var wait_time: float;
#var wait_time_buffer: float;
#var room_state := RoomState.State.INACTIVE;
#@export var reward_score: int;
#@export var penalty_score: int;
#var child_nodes: Array[Node];
#
#signal room_triggered;
#signal room_completed(reward: int);
#signal room_failed(penalty: int);
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#seed(Time.get_unix_time_from_system())
	#if !has_task: return;
	## Turn the scene unless its the main scene
	#child_nodes = get_children();
	#for node in child_nodes:
		#node.set_process(false);
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	## Decrease the cooldown for the room to 'fail' (have a task)
	#udpdate_cooldown(delta);
	#if room_state == RoomState.State.INACTIVE: return;
	## Decrease the task's timer
	#update_wait_time(delta);
#
#
#func timeout() -> void:
	#var rng = RandomNumberGenerator.new();
	#cooldown_buffer = cooldown + rng.randf_range(rand_add_range.x, rand_add_range.y);
#
#
#func udpdate_cooldown(delta: float) -> void:
	#cooldown_buffer -= delta;
	#if cooldown_buffer > 0.0: return;
	## Signal that this room has a task
	#room_triggered.emit();
#
#
#func update_wait_time(delta: float) -> void:
	#wait_time_buffer -= delta;
	#if wait_time_buffer > 0.0: return;
	## Signal that this room's task has been failed
	#room_failed.emit(penalty_score);
#
#
#func set_is_scene_active(active_state: bool):
	#if active_state:
		#for node in child_nodes:
			#node.set_process(true);
	#else:
		#for node in child_nodes:
			#node.set_process(false);
#
#
#func _on_room_triggered() -> void:
	#room_state = RoomState.State.ACTIVE;
#
#
#func _on_room_failed(_penalty: int) -> void:
	#room_state = RoomState.State.INACTIVE;
#
#
#func _on_room_completed(_reward: int) -> void:
	#room_state = RoomState.State.INACTIVE;
