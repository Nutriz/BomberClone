extends StaticBody2D


func destroy():
	$Particles2D.restart()
	$Sprite.hide()