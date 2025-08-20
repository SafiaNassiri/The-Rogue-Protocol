extends CharacterBody2D

# Customizable variables for movement
@export var speed = 300.0
@export var jump_velocity = -400.0

# How strong is gravity?
# It's a good practice to keep it consistent across all objects
var gravity = 800.0
var glitch_meter = 0

# The _physics_process function is called every physics frame
func _physics_process(delta):
	# Handle gravity
	velocity.y += gravity * delta
	
	# Handle jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Handle horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# This is Godot's built-in function to move the character
	# and handle collisions
	move_and_slide()


func _on_data_fragment_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		glitch_meter += 20 # Increase the meter by a value
		if glitch_meter > 100: # Make sure the meter doesn't go over 100
			glitch_meter = 100
		# The fragment is still in the scene tree at this point, so we need to delete it.
		# This is where we call our queue_free() function on the fragment itself.
		# We need a reference to the fragment that was just touched.
		body.queue_free() 
