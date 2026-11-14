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
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and not clicked:
			clicked = true
			$Sprite2D.visible = false
			$particles.visible = true
			for child in $particles.get_children():
				child.emitting = true
			Global.score += (1*Global.score_mult)
			await $particles.get_child(0).finished
			self.queue_free()
