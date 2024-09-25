extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Ball":
		#body.speed = 0
		body.direction.y = 1


func _on_collision_shape_2d_child_entered_tree(node):
	pass # Replace with function body.
