extends Button

var base_pos = Vector2(0,0)
var target_pos = Vector2(0,0)
var values = [Global.max_cooldown,Global.crosshairs,Global.score_mult]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_pos = position
	position.x = -get_viewport().get_visible_rect().size.x
	target_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	values = [Global.max_cooldown,Global.crosshairs,Global.score_mult]
	get_child(1).text = "Current: " + str(values[get_meta("item_number")])
	position += (target_pos-position)/16
