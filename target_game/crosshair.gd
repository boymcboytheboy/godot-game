extends Node2D

var offset := Vector2(0,0)
var fake_click = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var pos_offset = get_viewport().get_mouse_position() + offset
	position += (snapped(pos_offset,Vector2(48,48))-position)/2


	
