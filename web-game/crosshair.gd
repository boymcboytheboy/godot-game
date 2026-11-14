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


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not fake_click:
		if event.button_index == MOUSE_BUTTON_LEFT:
			simulate_click(position)
	




func simulate_click(click_position: Vector2) -> void:
	fake_click = true
	# 1. Create and configure the mouse down event
	var click_event = InputEventMouseButton.new()
	click_event.button_index = MOUSE_BUTTON_LEFT
	click_event.position = click_position
	click_event.global_position = click_position
	click_event.pressed = true
	
	# 2. Send the press event
	Input.parse_input_event(click_event)
	await get_tree().process_frame
	fake_click = false
