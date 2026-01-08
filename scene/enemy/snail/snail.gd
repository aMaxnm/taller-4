extends CharacterBody2D

#referencias alos nodos en escena
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_detector: RayCast2D = $FloorDetection
@onready var wall_detector: RayCast2D = $WallDetection
@onready var hitbox_collision:  CollisionShape2D = $HitBox/CollisionShape2D

#region constantes de movimiento
const GRAVITY: float = 1000.0
const MOVEMENT_SPEED: float = 3500.0
#endregion
enum FACING_DIRECTION {LEFT = -1, RIGHT = 1}
var facing: FACING_DIRECTION = FACING_DIRECTION.LEFT
var destroyed: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if destroyed and not anim_sprite.is_playing():
		queue_free()

func _physics_process(delta: float) -> void:
	if not destroyed:
		move_and_slide()
		if not is_on_floor():
			velocity.y += GRAVITY * delta
		else:
			velocity.x = MOVEMENT_SPEED * facing * delta 
			if wall_detector.is_colliding() or not floor_detector.is_colliding():
				flip_snail()

func flip_snail():
	if facing == FACING_DIRECTION.LEFT:
		facing = FACING_DIRECTION.RIGHT
	else:
		facing = FACING_DIRECTION.LEFT
	
	wall_detector.target_position *= -1
	floor_detector.position.x = floor_detector.position.x * -1
	anim_sprite.flip_h = !anim_sprite.flip_h

func _on_hit_box_area_entered(area: Area2D) -> void:
	destroyed = true
	anim_sprite.animation = "destroy"
	hitbox_collision.set_deferred("disabled", true)
