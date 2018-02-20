extends KinematicBody2D

export var player_speed = 10

var motion = Vector2();
var player_state = "idle"
onready var animator = $Sprite/AnimationPlayer

var player_animation = "ilde"
var player_next_animation = "ilde"

enum {IDLE, MOVING, DIE}

var todel = 0

func _process(delta):

	get_player_state(delta)
	set_animation()
	move_and_slide(motion)

	# for breakable bricks test
	check_collision()

func check_collision():
	for ray in $RayCasts.get_children():
		if ray.is_colliding() and ray.get_collider().has_method("destroy"):
			ray.get_collider().destroy()

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