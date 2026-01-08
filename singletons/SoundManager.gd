extends Node

const PLAYER_SOUND_HURT = "hurt"
const PLAYER_SOUND_LAND = "land"
const PLAYER_SOUND_JUMP = "jump"
const PLAYER_SOUND_PIKCUP = "pickup"

var SOUNDS = {
	PLAYER_SOUND_HURT : preload("res://assets/sounds/damage.wav"),
	PLAYER_SOUND_JUMP : preload("res://assets/sounds/jump.wav"),
	PLAYER_SOUND_LAND : preload("res://assets/sounds/land.wav"),
	PLAYER_SOUND_PIKCUP : preload("res://assets/sounds/pickup.wav")
}

func play_sound(audio_player: AudioStreamPlayer2D, clip_key: String):
	audio_player.stream = SOUNDS[clip_key]
	audio_player.play()
