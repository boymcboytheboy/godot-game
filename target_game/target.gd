extends Node2D

var target_position = 0
var clicked = false


func _ready() -> void:
	await get_tree().create_timer(Global.max_cooldown).timeout
	target_position.y = get_viewport().get_visible_rect().size.y + 50
	while not position.y >= get_viewport().get_visible_rect().size.y + 20:
		await get_tree().create_timer(0.1).timeout
	$particles/GPUParticles2D2.emitting = true
	await $particles/GPUParticles2D2.finished
	Global.max_cooldown += -0.1
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += (Vector2(target_position) - position)/15
	

func _input(event) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and not clicked:
			clicked = true
			var near = false
			for child in get_parent().get_parent().get_node("crosshairs").get_children():
				if round(position.distance_to(child.position)) < 32:
					near = true
			if near:
				$Sprite2D.visible = false
				$particles.visible = true
				for particles in $particles.get_children():
					particles.emitting = true
				Global.score += (1*Global.score_mult)
				await $particles.get_child(0).finished
				self.queue_free()
			else:
				clicked = false
