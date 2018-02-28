extends Area2D

enum Types {BOMB, EXPAND_BOMB}
var item_type
var sprite
signal _on_item_picked


func _ready():
	define_item_type()
	show_item()


func define_item_type():
	if randi() % 2 == 0:
		item_type = Types.BOMB
		sprite = $BombSprite
	else:
		item_type = Types.EXPAND_BOMB
		sprite = $ExpandBombSprite

func show_item():
	$Tween.interpolate_property(sprite, "modulate", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()

func hide_item():
	$Tween.interpolate_property(sprite, "modulate", Color(0, 0, 0, 1), Color(0, 0, 0, 0), 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()

func _on_Item_body_entered(body):
	printt(body, " picked ", item_type)
	emit_signal("_on_item_picked", item_type)
	hide_item()
