extends CanvasLayer

@onready var finished_lbl: Label = $MarginContainer/FINISHED
@onready var continue_lbl: Label = $MarginContainer/continuelbl
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


var can_return_to_menu: bool = false

func _ready() -> void:
	visible = false
	can_return_to_menu = false
	SignalManager.on_finished.connect(show_finished)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and can_return_to_menu:
		SignalManager.on_restart_game.emit()

func show_finished() -> void:
	print("Finished")
	visible = true

	# Mostrar directamente los labels
	finished_lbl.visible = true
	continue_lbl.visible = true

	# Reproducir sonido final
	SoundManager.play_sound(audio_player, SoundManager.FINAL)

	# Permitir volver al menú
	can_return_to_menu = true
