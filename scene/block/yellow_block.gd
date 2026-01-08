extends StaticBody2D

@export var fruit_scene: PackedScene
var used := false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if used:
		return
	
	if area.name == "Hitbox":
		used = true
		spawn_fruit()
		bounce()
		fade_sprite()

func spawn_fruit() -> void:
	if fruit_scene:
		var fruit_instance = fruit_scene.instantiate()
		fruit_instance.global_position = global_position + Vector2(0, -30)
		get_tree().current_scene.call_deferred("add_child", fruit_instance)

func bounce() -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -5), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", position, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func fade_sprite() -> void:
	$Sprite2D.modulate = Color(0.2, 0.2, 0.2, 7)
