extends Camera2D

@export var player: Player
@onready var shake_timer: Timer = $Timer

const SHAKE_AMAOUNT: float = 10
const SHAKE_TIME: float = 0.7

var is_shaking: bool

func _ready() -> void:
	SignalManager.on_hurt.connect(start_shaking)
	is_shaking = false

func _process(delta: float) -> void:
	position = player.position
	if is_shaking:
		offset = Vector2(
			randf_range(-SHAKE_AMAOUNT, SHAKE_AMAOUNT),
			randf_range(-SHAKE_AMAOUNT, SHAKE_AMAOUNT)
		)

func start_shaking():
	is_shaking = true
	shake_timer.start(SHAKE_TIME)

func _on_timer_timeout() -> void:
	is_shaking = false
	offset = Vector2.ZERO
