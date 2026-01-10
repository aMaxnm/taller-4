extends Node

const PLAYER_SOUND_HURT   = "hurt"
const PLAYER_SOUND_LAND   = "land"
const PLAYER_SOUND_JUMP   = "jump"
const PLAYER_SOUND_PICKUP = "pickup"
const FINAL               = "final"

var SOUNDS := {
	PLAYER_SOUND_HURT   : preload("res://assets/sounds/damage.wav"),
	PLAYER_SOUND_JUMP   : preload("res://assets/sounds/jump.wav"),
	PLAYER_SOUND_LAND   : preload("res://assets/sounds/land.wav"),
	PLAYER_SOUND_PICKUP : preload("res://assets/sounds/pickup.wav"),
	FINAL               : preload("res://assets/sounds/FINAL.wav")
}

func play_sound(audio_player: AudioStreamPlayer2D, clip_key: String) -> void:
	if clip_key in SOUNDS:
		audio_player.stream = SOUNDS[clip_key]
		audio_player.play()
