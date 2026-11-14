extends Node

var score = 0
var max_cooldown := 4.0:
	set(value):
		value = clamp(value,0.0,5.0)
var target_position := Vector2(0,-3000)
var score_mult := 1.0
var crosshairs = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_position.x = get_viewport().get_visible_rect().size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func transition(scene):
	var rect = get_tree().current_scene.get_node("TextureRect")
	target_position = Vector2(get_viewport().get_visible_rect().size.x,-3000)
	rect.position = target_position
	target_position.y = -get_viewport().get_visible_rect().size.y
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	while not round(rect.position) == target_position:
		await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(scene)
	await get_tree().create_timer(1).timeout
	target_position.y = get_viewport().get_visible_rect().size.y
