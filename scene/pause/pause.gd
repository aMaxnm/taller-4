extends CanvasLayer

@onready var container: Control = $MarginContainer

var isPaused: bool = false

func _ready() -> void:
	#process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	set_process_input(true) 
	visible = false

func _on_toggle_pause() -> void:
	visible = GameManager.is_paused

func _on_resume_pressed() -> void:
	SignalManager.toggle_pause.emit()
	if isPaused:
		visible = false

func _on_menu_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		isPaused = true
		SignalManager.toggle_pause.emit()
		_on_toggle_pause.call_deferred()
