extends Node2D

@onready var sprite = $Sprite2D
const Receipt = preload("res://Scenes/receipt.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	sprite.scale = Vector2(1.05, 1.05);


func _on_area_2d_mouse_exited() -> void:
	sprite.scale = Vector2(1, 1);


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.is_pressed():
		var receipt = create_receipt()
		add_child(receipt)

func create_receipt() -> Node2D:
	return Receipt.instantiate()
