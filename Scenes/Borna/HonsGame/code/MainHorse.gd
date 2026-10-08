extends Control

var bird := preload("res://Scenes/Borna/HonsGame/Bird.tscn")
var obstacle := preload("res://Scenes/Borna/HonsGame/Obstacle.tscn")
var obstacle_types:=[bird,obstacle]
var bird_height:=[370,420]
var can_spawn:=true
#vars
const hons_start_pos := Vector2i(310,423)
var maxspawngap: float=1.2
var speed: float=0.7



func _ready():
	print("start")
	scale_with_difficulty()
	new_game()
	
	$Timer.start()
	
func scale_with_difficulty() -> void:
	var node := get_parent();
	var controller := node as DistractionControllerBase;
	var diff: float = controller.get_difficulty(); 
	speed=0.9+diff*0.03
	maxspawngap= 1.2-(0.02*diff)
	$Timer.wait_time=8.0+(diff*0.3)
	
func new_game():
	$HonsChar.position=hons_start_pos
	
func _on_timer_timeout():
	game_won()
	print("win")
	queue_free()
func _process(delta):
	gen_obs()
	$Label.set_text(str(int($Timer.get_time_left())))
	

		
	
	
func gen_obs():
	
	if can_spawn:
		can_spawn=false
		var timer = randf_range(0.55,maxspawngap)
		await get_tree().create_timer(timer).timeout
		
		var obs_type=obstacle_types[randi()%obstacle_types.size()]
		var obs = obs_type.instantiate() 
		add_child(obs)
		if obs_type==obstacle_types[0]:
			var y= randf_range(416,370)
			obs.position=Vector2(700,y)
			can_spawn=true
		else:
			obs.position=Vector2(700,394)
			can_spawn=true
		obs.body_entered.connect(hit_obs)
	

func hit_obs(body):
	if body.name=="HonsChar":
		print("hit")
		game_lost()
	
func game_won():	
	GlobalDistractionManager.set_distraction_active_state(false);
	speed=0
	queue_free()
	
func game_lost():
	GlobalDistractionManager.set_distraction_active_state(false);
	GlobalStrikeManager.update_strikes(1);	# Hard coded
	speed=0
	$HonsChar.queue_free()
	$Timer.stop()
	queue_free()
	
	
	
