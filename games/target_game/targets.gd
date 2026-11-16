extends Node

var target_cooldown := 0.0
var crosshairs = 1:
	set(value):
		value = clamp(value,1,25)
		Global.crosshairs = value
		crosshairs = value
		for child in $crosshairs.get_children():
			$crosshairs.remove_child(child)
			child.queue_free()
		print($crosshairs.get_children())
		for i in range(value):
			var new = load("res://crosshair.tscn")
			new = new.instantiate()
			$crosshairs.add_child(new)
		var number = 0
		for child in $crosshairs.get_children():
			child.offset.x = ((0 - (wrapi(crosshairs,0,6)/2)* 48)+(wrapi(number,0,5)*48))
			child.offset.y = ((0 - (floor(float(crosshairs)/6)/2)* 48)+(floor(float(number)/5)*48))
			number += 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$Parallax2D/Sprite2D.texture.noise.seed = randi()
	crosshairs = Global.crosshairs


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target_cooldown += -delta
	if target_cooldown <= 0:
		target_cooldown = Global.max_cooldown
		spawn(1)


func spawn(number):
	for i in range(number):
		var target = load("res://target.tscn")
		target = target.instantiate()
		$targets.add_child(target)
		var screen_size: Vector2 = get_viewport().get_visible_rect().size
		var rand_x = randi_range(48,screen_size.x-48)
		var rand_y = randi_range(48,screen_size.y-48)
		var target_pos = snapped(Vector2i(rand_x,rand_y),Vector2i(48,48))
		target.target_position = target_pos
		target.position = target.target_position
		target.position.y = -1000



func _on_shop() -> void:
	Global.transition("res://shop.tscn")
