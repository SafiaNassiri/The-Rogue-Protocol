extends Area2D

func _on_body_entered(body):
	# Check if the colliding body is the player
	if body.name == "Player":
		# Emit a signal to tell the main scene that the player collected a fragment
		emit_signal("collected_fragment")
		# Remove the fragment from the scene
		queue_free()
