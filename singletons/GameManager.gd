extends Node

var menu_scene: PackedScene = preload("res://scene/menu/menu.tscn")

var lives: int = 3
var score: int = 0
var is_paused: bool = false 

@onready var player = $Player



func _ready() -> void:
	SignalManager.on_hurt.connect(on_hurt_received)
	SignalManager.on_bonus_grabbed.connect(on_bonus_grabbed)
	SignalManager.toggle_pause.connect(_on_toggle_pause)
	
func _on_toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = is_paused
	SignalManager.on_restart_game.connect(return_to_menu)

func on_hurt_received():
	lives -= 1
	SignalManager.on_lives_changed.emit(lives)

	# Si se acaban las vidas
	if lives <= 0:
		SignalManager.on_game_over.emit()

func on_bonus_grabbed(bonus_score: int):
	score += bonus_score
	SignalManager.on_score_changed.emit(score)

func return_to_menu():
	get_tree().paused = false
	score = 0
	lives = 3  # Reinicia las vidas
	SignalManager.on_lives_changed.emit(lives) # Notifica a la UI
	get_tree().change_scene_to_packed(menu_scene)
