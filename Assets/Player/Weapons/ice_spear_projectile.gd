extends Projectile

var level = 1
var hp = 1
@export var knockback_amount = 100
var attack_size = 1.0
@onready var collisionShape = $CollisionShape2D


var target = Vector2.ZERO # Global position of target
var angle = Vector2.ZERO
#@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	$DestroyTimer.start()
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	set_speed(100) # Default
	
	
func _physics_process(delta):
	position += angle * speed * delta


func _on_destroy_timer_timeout():
	queue_free()


func set_damage(val : float): # Override from Projectile
	$DamageBox.damage = val
	
func set_attack_speed(val : float):
	$DamageBox.attack_speed = val


func _on_damage_box_area_entered(area):
	hp -= 1
	if hp <= 0: queue_free()
