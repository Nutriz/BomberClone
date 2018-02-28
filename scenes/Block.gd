extends StaticBody2D

signal drop_item

func destroy():
	if not $CollisionShape2D.disabled:
		$Particles2D.restart()
		$Sprite.hide()
		$CollisionShape2D.queue_free()
		$Timer.start()

		var drop = randi() % 3
		if drop == 2:
			emit_signal("drop_item", self.position)


func _on_Timer_timeout():
	self.queue_free()
