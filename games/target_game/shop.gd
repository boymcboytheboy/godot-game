extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Parallax2D/Sprite2D.texture.noise.seed = randi()
	while not round($TextureRect.position) == Global.target_position:
			await get_tree().create_timer(0.5).timeout
	await get_tree().create_timer(1).timeout
	for child in $Control.get_children():
		child.pressed.connect(_on_purchase.bind(child))
		child.target_pos = child.base_pos
		await get_tree().create_timer(0.1).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back() -> void:
	Global.transition("res://main.tscn")


func _on_purchase(sender: Button) -> void:
	if Global.score >= sender.get_meta("cost"):
		Global.score += -sender.get_meta("cost")
		if sender.get_meta("item_number") == 0:
			Global.max_cooldown += 0.1
		elif sender.get_meta("item_number") == 1:
			Global.crosshairs += 1
		else:
			Global.score_mult += 0.1
