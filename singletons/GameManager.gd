extends Node

var lives: int = 3
var score: int = 0
var is_paused: bool = false 

func _ready() -> void:
	SignalManager.on_hurt.connect(on_hurt_received)
	SignalManager.on_bonus_grabbed.connect(on_bonus_grabbed)
	SignalManager.toggle_pause.connect(_on_toggle_pause)
	
func _on_toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = is_paused

func on_hurt_received():
	lives -= 1
	SignalManager.on_lives_changed.emit(lives)

func on_bonus_grabbed(bonus_score: int):
	score += bonus_score
	SignalManager.on_score_changed.emit(score)
