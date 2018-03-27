extends KinematicBody2D

export var player_speed = 10

var motion = Vector2();
var player_state = "idle"
onready var animator = $Sprite/AnimationPlayer

var player_animation = "ilde"
var player_next_animation = "ilde"

enum {IDLE, MOVING, DIE}

var bomb_count = 1
var bomb_power = 1 # in tile unit
var can_bombing = true

onready var bomb_scn = preload("res://scenes/Bomb.tscn")

func _process(delta):
	get_player_state(delta)
	set_animation()
	move_and_slide(motion)


func get_player_state(delta):
	if(Input.is_action_pressed("move_right")):
		set_motion(delta, Vector2(player_speed, 0))
		player_next_animation = "move_right"
		player_state = MOVING
	elif(Input.is_action_pressed("move_left")):
		set_motion(delta, Vector2(-player_speed, 0))
		player_next_animation = "move_left"
		player_state = MOVING
	elif(Input.is_action_pressed("move_up")):
		set_motion(delta, Vector2(0, -player_speed))
		player_next_animation = "move_top"
		player_state = MOVING
	elif(Input.is_action_pressed("move_down")):
		set_motion(delta, Vector2(0, player_speed))
		player_next_animation = "move_bot"
		player_state = MOVING
	else:
		set_motion(delta, Vector2(0,0));
		player_state = IDLE

	if (Input.is_action_pressed("drop_bomb")):
		if can_bombing and bomb_count > 0:
			bomb_count -= 1
			drop_bomb()


func set_animation():
	if (player_next_animation != player_animation):
		if(player_next_animation == "idle"):
			animator.stop();
		else:
			animator.play(player_next_animation);
		player_animation = player_next_animation
	pass


func set_motion(delta, speed):
	motion.x = speed.x*delta;
	motion.y = speed.y*delta;

func drop_bomb():
	var bomb = bomb_scn.instance()
	bomb.position = position
	bomb.connect("explode", self, "_on_bomb_explode")
	$"..".add_child(bomb)
	can_bombing = false
	$CanBombingTimer.start()

func _on_item_picked(item):
	if item.item_type == item.Types.BOMB:
		bomb_count += 1
	elif item.item_type == item.Types.EXPAND_BOMB:
		bomb_power += 1

func _on_bomb_explode():
	bomb_count += 1

func _on_CanBombingTimer_timeout():
	can_bombing = true
