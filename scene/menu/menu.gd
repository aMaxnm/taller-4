extends MarginContainer

var mainLevelScene = preload("res://scene/test_level/test_level.tscn")

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_packed(mainLevelScene)

func _on_texture_button_2_pressed() -> void:
	get_tree().quit()
