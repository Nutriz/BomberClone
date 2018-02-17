extends KinematicBody2D

export var player_speed = 10


var motion = Vector2();
var player_state = "idle"
onready var animator = $Sprite/AnimationPlayer

var player_animation = "ilde"
var player_next_animation = "ilde"

func _process(delta):

	get_player_state(delta)
	set_animation()
	move_and_slide(motion)
	

func get_player_state(delta):
	
	if(Input.is_action_pressed('ui_right')):
		set_motion(delta,Vector2(player_speed,0))
		player_next_animation = "move_right"
		player_state = "moving"
	elif(Input.is_action_pressed('ui_left')):
		set_motion(delta,Vector2(-player_speed,0))
		player_next_animation = "move_left"
		player_state = "moving"
	elif(Input.is_action_pressed("ui_up")):
		set_motion(delta,Vector2(0,-player_speed))
		player_next_animation = "move_top"
		player_state = "moving"
	elif(Input.is_action_pressed("ui_down")):
		set_motion(delta,Vector2(0,player_speed))
		player_next_animation = "move_bot"
		player_state = "moving"
	else:
		set_motion(delta,Vector2(0,0));
		player_state = "idle"
		
	
		

func set_animation():		
	if (player_next_animation != player_animation):
		if(player_next_animation == "idle"):
			animator.stop();
		else:
			animator.play(player_next_animation);
		player_animation = player_next_animation
	pass
	

func set_motion(delta,speed):
	motion.x = speed.x*delta;
	motion.y = speed.y*delta;