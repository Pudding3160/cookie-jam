extends CanvasLayer

@onready var texture := $CenterContainer/TextureRect
@export var timer: float
var timer_buffer;
@export var next_scene: PackedScene
var can_cd := false
var main_game: Node  

func _ready() -> void:
	reset();

func show_fired() -> void:
	main_game = get_tree().root.get_child(-1);
	can_cd = true
	var tween := create_tween()
	tween.tween_property(texture, "modulate", Color(1, 1, 1, 1), 2);

func _process(delta: float) -> void:
	if (!can_cd): return;
	timer_buffer -= delta;
	if (timer_buffer <= 0):
		end_game()
		can_cd = false;

func _on_timer_timeout() -> void:
	var result: bool = await SceneTransition.fade_in();
	if result:
		var scene := next_scene.instantiate();
		get_tree().root.add_child(scene);
		SceneTransition.fade_out();
		queue_free();


func end_game():
	var result: bool = await SceneTransition.fade_in();
	if result:
		var scene := next_scene.instantiate();
		get_tree().root.add_child(scene);
		SceneTransition.fade_out();
		RoomManager.clear_children();
		GlobalDistractionManager.reset()
		GlobalStrikeManager.reset()
		main_game.queue_free()
		reset()

func reset():
	texture.modulate.a = 0
	timer_buffer = timer
