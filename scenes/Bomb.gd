extends StaticBody2D

signal explode
signal fire_touched

func explode():
	$Particles.restart()
	$Sprite.hide()
	$CollisionShape.disabled = true

	check_fire_collision()
	# TODO displays flames

func check_fire_collision():
	for ray in $Rays.get_children():
		if ray.is_colliding():
			print("print: ", ray.get_collider())
			emit_signal("fire_touched")


func _on_BoumTimer_timeout():
	emit_signal("explode")
	explode()

func _on_Area2D_body_exited(body):
	# If player exit the bomb zone, make it collisionable
	$CollisionShape.disabled = false
