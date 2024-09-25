extends Area2D

class_name Block

signal block_destroyed(points)

const BLOCK_SIZE_X: int = 26
const BLOCK_SIZE_Y: int = 59

@export var energy = 2
@export var has_key = false
@export var points = 100

var down_border: int = 0
var up_border: int = 0
var left_border: int = 0
var right_border: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.down_border = self.position.y + (BLOCK_SIZE_X / 2)
	self.up_border = self.position.y - (BLOCK_SIZE_X / 2)
	self.left_border = self.position.x - (BLOCK_SIZE_X / 2)
	self.right_border = self.position.x + (BLOCK_SIZE_X / 2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _collide_down(body) -> bool:
	if body.position.y > self.down_border:
		return true
	return false
	
func _collide_up(body) -> bool:
	if body.position.y < self.down_border:
		return true
	return false
	
func _collide_left(body) -> bool:
	if body.position.x < self.left_border:
		return true
	return false

func _collide_right(body) -> bool:
	if body.position.x > self.right_border:
		return true
	return false


func _on_body_entered(body):
	if body.name == "Ball":
		if self._collide_down(body):
			body.direction = -body.direction
		if self._collide_up(body):
			body.direction = -body.direction
		if self._collide_right(body):
			body.direction.x = -body.direction.x
			
		
		body.play_bounce_sound()
		print("Ball position: ", body.position)
		print("Block position: ", self.position)
	
	self.energy -= 1
	if self.energy == 0:
		# destroy block
		self.queue_free()
		block_destroyed.emit(self.points)


func _on_child_entered_tree(node):
	pass # Replace with function body.
