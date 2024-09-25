extends Area2D

@export var speed = 400
@export var player_size = 128
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	

func _on_body_entered(body):
	if body.name == "Ball":
		#body.speed = 0
		var ball_pos = body.position
		var player_pos = self.position
		
		var contact_point_x = ball_pos.x - player_pos.x
		if contact_point_x > 1 and contact_point_x < 10:
			body.direction.x = 0.5
		if contact_point_x > 10:
			body.direction.x = 1
		
		if contact_point_x < 0 and contact_point_x > -10:
			body.direction.x = -0.5
		if contact_point_x < -10:
			body.direction.x = -1
		
			
		body.direction.y = -1
		
