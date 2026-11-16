extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Parallax2D/Sprite2D.texture.noise.seed = randi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	Global.transition("res://main.tscn")
