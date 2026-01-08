extends CharacterBody2D

class_name Player

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var invincible_timer: Timer = $InvencibleTimer
@onready var jump_hitbox_collision = $JumpHitBox/CollisionShape2D

enum PLAYER_STATES {IDLE, WALKING, JUMP, FALL, HURT, CROUCH}
const MOVEMENT_SPEED: float = 250
const JUMP_SPEED: float = -500
const GRAVITY:float = 1000
const MAX_FALL_SPEED: float = GRAVITY * 3
const HURT_JUMP_SPEED: float = -150.0
const ENEMY_BOUNCE_SPEED: float = -550.0


var current_state: PLAYER_STATES = PLAYER_STATES.IDLE

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if current_state != PLAYER_STATES.HURT:
		if not is_on_floor():
			velocity.y += GRAVITY * delta
		else:
			velocity.y = 0
		velocity.y = clampf(velocity.y, ENEMY_BOUNCE_SPEED, MAX_FALL_SPEED)
		calculate_state()
		get_input(delta)
	move_and_slide()

func get_input(delta: float):
	velocity.x = 0
	#region movimiento lateral
	if(Input.is_action_pressed("move_l")):
		velocity.x =-MOVEMENT_SPEED
		sprite.flip_h = true
	elif(Input.is_action_pressed("move_r")):
		velocity.x = MOVEMENT_SPEED
		sprite.flip_h = false
	#endregion
	#region salto
	if(Input.is_action_just_pressed("jump") and is_on_floor()):
		velocity.y = JUMP_SPEED
	#endregion

func calculate_state():
	if not is_on_floor():
		if velocity.y < 0:
			set_state(PLAYER_STATES.JUMP)
		else:
			set_state(PLAYER_STATES.FALL)
	elif Input.is_action_pressed("move_down"):
		set_state(PLAYER_STATES.CROUCH)
	elif velocity.x != 0:
		set_state(PLAYER_STATES.WALKING)
	else:
		set_state(PLAYER_STATES.IDLE)

func set_state(new_state: PLAYER_STATES):
	if (current_state != new_state): 
		if current_state == PLAYER_STATES.FALL and (new_state == PLAYER_STATES.IDLE or new_state == PLAYER_STATES.WALKING):
			SoundManager.play_sound(audio_player, SoundManager.PLAYER_SOUND_LAND)
			jump_hitbox_collision.disabled = true
		current_state = new_state
		match current_state:
			PLAYER_STATES.IDLE:
				anim_player.play("idle")
			PLAYER_STATES.WALKING:
				anim_player.play("walking")
			PLAYER_STATES.JUMP:
				anim_player.play("jump")
				SoundManager.play_sound(audio_player, SoundManager.PLAYER_SOUND_JUMP)
			PLAYER_STATES.FALL:
				anim_player.play("fall")
				jump_hitbox_collision.disabled = false
			PLAYER_STATES.CROUCH:
				anim_player.play("crouch")
			PLAYER_STATES.HURT:
				anim_player.play("hurt")
				SoundManager.play_sound(audio_player, SoundManager.PLAYER_SOUND_HURT)
	else:
		pass

func _on_hitbox_area_entered(area: Area2D) -> void:
	apply_hit()
	SignalManager.on_hurt.emit()

func apply_hit():
	velocity.x = 0
	velocity.y = HURT_JUMP_SPEED
	set_state(PLAYER_STATES.HURT)
	invincible_timer.start()
	#código para tween (animación por código)
	var tween = get_tree().create_tween()
	tween.set_loops(1)
	tween.tween_property(sprite, "self_modulate", Color(1,0,0,0.5), 0.5)
	tween.tween_property(sprite, "self_modulate", Color(1,1,1,1), 0.5)

func _on_invencible_timeout() -> void:
	set_state(PLAYER_STATES.IDLE)
	velocity.y = 0

func _on_jump_hit_box_area_entered(area: Area2D) -> void:
	velocity.y = ENEMY_BOUNCE_SPEED
