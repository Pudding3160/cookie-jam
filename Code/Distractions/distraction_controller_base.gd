class_name DistractionControllerBase extends Node

@export var interval := 30;
var interval_buffer;
@export var difficulty := 1;
@export var max_rand_num := 30;
@export var distraction_scene: PackedScene
var is_destraction_active := false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interval_buffer = interval;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If the number of children is greater than zero, the distraction is active
	is_destraction_active = get_child_count() > 0;
	if (is_destraction_active): return;
	
	# Decrease interval buffer
	interval_buffer -= delta;
	if interval_buffer > 0.0: return;
	
	# Reset the timer for future use
	interval_buffer = interval;
	
	# Check for spawn chance
	#if !can_spawn(0, max_rand_num): return;	# Will be added later
	start_game();

func can_spawn(min: int, max: int) -> bool:
	var rng = RandomNumberGenerator.new();
	return difficulty > rng.randi_range(min, max);


func start_game() -> void:
	var scene_instance = distraction_scene.instantiate();
	add_child(scene_instance);


func get_difficulty() -> int:
	return difficulty;
