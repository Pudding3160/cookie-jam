extends Node2D
@onready var coffeedif=$CoffeeDiff
@onready var honsdifftext=$HonsDiff
@onready var bombdifftext=$BombDiff
@onready var emaildifftext=$EmailDiff
@onready var match3difftext=$Match3Diff
var coffeediff: int =0
var honsdiff: int=0
var bombdiff: int =0
var emaildiff: int=0
var match3diff: int=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coffeediff=1
	emaildiff=1
	bombdiff=1
	match3diff=1
	honsdiff=1
	
	coffeedif.text = str(coffeediff)
	emaildifftext.text = str(emaildiff)
	bombdifftext.text = str(bombdiff)
	match3difftext.text = str(match3diff)
	honsdifftext.text = str(honsdiff)

#coffe game 
func _on_coffee_diff_down_pressed() -> void:
	if(coffeediff>1):
		coffeediff-=1
		coffeedif.text=str(coffeediff)
		print(coffeediff)
func _on_coffee_diff_up_pressed() -> void:
	if(coffeediff<20):
		coffeediff+=1
		coffeedif.text=str(coffeediff)
		print(coffeediff)

#hons game

func _on_hons_diff_down_pressed() -> void:
	if(honsdiff>1):
		honsdiff-=1
		honsdifftext.text=str(honsdiff)
		


func _on_hons_diff_up_pressed() -> void:
	if(honsdiff<20):
		honsdiff+=1
		honsdifftext.text=str(honsdiff)

#bomb diff



func _on_bomb_diff_down_pressed() -> void:
	if(bombdiff>1):
		bombdiff-=1
		bombdifftext.text=str(bombdiff)
		# Replace with function body.



func _on_bomb_diff_up_pressed() -> void:
	if(bombdiff<20):
		bombdiff+=1
		bombdifftext.text=str(bombdiff)
		
		
#email diff



func _on_email_diff_down_pressed() -> void:
	if(emaildiff>1):
		emaildiff-=1
		emaildifftext.text=str(emaildiff)
	

	


func _on_email_diff_up_pressed() -> void:
	if(emaildiff<20):
		emaildiff+=1
		emaildifftext.text=str(emaildiff)
		
#match3 diff


	


func _on_match_3_diff_down_pressed() -> void:
	if(match3diff>1):
		match3diff-=1
		match3difftext.text=str(match3diff)
	
	



func _on_match_3_diff_up_pressed() -> void:
	if(match3diff<20):
		match3diff+=1
		match3difftext.text=str(match3diff)
		




func _on_start_game_pressed() -> void:
	DifficultyManager.diffbomb=bombdiff
	DifficultyManager.diffmatch3=match3diff
	DifficultyManager.diffhons=honsdiff
	DifficultyManager.diffemail=emaildiff
	DifficultyManager.diffCoffee=coffeediff
	get_tree().change_scene_to_file("res://Scenes/MAIN/main.tscn")
