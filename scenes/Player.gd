extends KinematicBody2D

export var player_speed = 10


var motion = Vector2();
var player_state = "idle"
var animator;
var player_animation = "ilde"
var player_next_animation = "ilde"

func _ready():

	animator = get_node("Sprite/AnimationPlayer");

	pass

func _process(delta):

	getPlayerState(delta);
	
	setAnimation();
	
	move_and_slide(motion)
	

	pass


func getPlayerState(delta):
	
	if(Input.is_action_pressed('ui_right')):
		setMotion(delta,Vector2(player_speed,0))
		player_next_animation = "move_right";
		player_state = "moving";
	elif(Input.is_action_pressed('ui_left')):
		setMotion(delta,Vector2(-player_speed,0))
		player_next_animation = "move_left";
		player_state = "moving";
	elif(Input.is_action_pressed("ui_up")):
		setMotion(delta,Vector2(0,-player_speed))
		player_next_animation = "move_top";
		player_state = "moving";
	elif(Input.is_action_pressed("ui_down")):
		setMotion(delta,Vector2(0,player_speed))
		player_next_animation = "move_bot"
		player_state = "moving";
	else:
		setMotion(delta,Vector2(0,0));
		player_state = "idle";
		
	
		

func setAnimation():
	

		
	if (player_next_animation != player_animation):
		if(player_next_animation == "idle"):
			animator.stop();
		else:
			animator.play(player_next_animation);
		player_animation = player_next_animation
	pass
	

func setMotion(delta,speed):
	motion.x = speed.x*delta;
	motion.y = speed.y*delta;