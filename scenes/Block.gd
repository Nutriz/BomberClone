extends StaticBody2D

func destroy():
	if not $CollisionShape2D.disabled:
		$Particles2D.restart()
		$Sprite.hide()
		$CollisionShape2D.queue_free()
		$Timer.start()

func _on_Timer_timeout():
	self.queue_free()
