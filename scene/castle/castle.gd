extends StaticBody2D

@export var player: Player
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
var used := false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if used:
		return
	
	if area.name == "Hitbox":
		used = true
		SoundManager.play_sound(audio_player, SoundManager.FINAL)
		SignalManager.on_finished.emit()
