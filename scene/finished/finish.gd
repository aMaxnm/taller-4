extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var continue_label: Label = $MarginContainer/ContinueLabel
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var can_return_to_menu: bool = false

func _ready() -> void:
	visible = false
	can_return_to_menu = false

	SignalManager.on_finished.connect(show_finished)
	anim_player.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and can_return_to_menu:
		get_tree().paused = false
		SignalManager.on_restart_game.emit()

func show_finished() -> void:
	print("Finished")
	get_tree().paused = true
	visible = true
	continue_label.visible = false
	anim_player.play("FINISHED")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "FINISHED":
		continue_label.visible = true
		SoundManager.play_sound(audio_player, SoundManager.FINAL)
		can_return_to_menu = true
