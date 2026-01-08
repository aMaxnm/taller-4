extends CanvasLayer

@onready var heart_container = $MC/HBoxContainer/HeartContainer
@onready var score_label = $MC/HBoxContainer/ScoreLabel

const DEFAULT_SCORE_TEXT = "Score: "
var heart_array: Array 

func _ready() -> void:
	heart_array = heart_container.get_children()
	SignalManager.on_score_changed.connect(on_score_changed)
	SignalManager.on_lives_changed.connect(on_lives_changed)

func on_score_changed(score: int):
	score_label.text = DEFAULT_SCORE_TEXT + str(score)

func on_lives_changed(lives: int):
	for idx in range(heart_array.size()):
		heart_array[idx].visible = idx < lives
