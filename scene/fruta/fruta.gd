extends Area2D

@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: CollisionShape2D = $CollisionShape2D

const score: int = 5

func _on_area_entered(area: Area2D) -> void:
	SignalManager.on_bonus_grabbed.emit(score)
	sprite_2d.visible = false
	particles.emitting = true
	SoundManager.play_sound(audio_player, SoundManager.PLAYER_SOUND_PIKCUP)
	hitbox.set_deferred("disabled", true)

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
