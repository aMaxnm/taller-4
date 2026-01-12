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
	SignalManager.on_restart_game.connect(returnToMenu)

func returnToMenu():
	score = 0
	_on_toggle_pause()
	get_tree().change_scene_to_packed(menu_scene)

func _on_toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = is_paused

	SignalManager.on_restart_game.connect(returnToMenu)

func on_hurt_received():
	lives -= 1
	SignalManager.on_lives_changed.emit(lives)

func on_bonus_grabbed(bonus_score: int):
	score += bonus_score
	SignalManager.on_score_changed.emit(score)
