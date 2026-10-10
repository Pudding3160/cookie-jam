class_name CoffeeController extends DistractionControllerBase

@export var sound: AudioStreamPlayer2D

func get_diff()->void: 
	difficulty=DifficultyManager.diffCoffee
	
func start_game() -> void:
	var scene_instance := distraction_scene.instantiate();
	add_child(scene_instance);
	attack_stored = false;


func _process(delta: float) -> void:
	# If an attack is stored, start the distraction; please dont ask bro i dont gaf
	if (attack_stored
			and RoomManager.current_room_type == active_room
			and !GlobalDistractionManager.get_distraction_active_state()
			and check_for_active_room):
		start_game();
		return;

	# If the distraction has a specific room assigned to it, it can't work unless that room is active
	var active := check_for_visibility();
	if (!active): set_children_state(false);
	else: set_children_state(true);

	# If the number of children is greater than zero, the distraction is active
	is_distraction_active = get_child_count() > 0;
	if (is_distraction_active): return;

	# Decrease interval buffer
	interval_buffer -= delta;
	if interval_buffer > 0.0: return;

	# Reset the timer for future use
	interval_buffer = interval;

	# Check if another distraction is active, only if the controller is set to perform the check
	if (GlobalDistractionManager.get_distraction_active_state() and check_for_other_distractions): return;
	# Check if the player is in the active room, if not store the attack
	if (!check_for_active_room):
		start_game();
	if (RoomManager.current_room_type != active_room):
		if attack_stored: return;
		attack_stored = true;
		sound.play()
	elif (check_for_active_room):
		start_game();
