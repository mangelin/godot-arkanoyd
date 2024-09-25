extends Node2D

class_name  Level

const BLOCK_EMPTY: String = "empty"
const BLOCK_GREEN: String = "green"
const BLOCK_RED: String = "red"


@export var start_position: Vector2 = Vector2(88, 139)
@export var gap: Vector2 = Vector2(65, 40)

var block = preload("res://Scenes/block.tscn")


const LEVEL = {
	"rows": [
		[
			{ "block": "green", "texture": "res://assets/blocks/blk-green.png"}, 
			{ "block": "red", "texture": "res://assets/blocks/blk-red.png", "energy": 3}, 
			{ "block": "empty"}, 
			{ "block": "green", "texture": "res://assets/blocks/blk-green.png"},
			{ "block": "green", "texture": "res://assets/blocks/blk-green.png"},
			{ "block": "green", "texture": "res://assets/blocks/blk-green.png"},
			{ "block": "green", "texture": "res://assets/blocks/blk-green.png"},
			{ "block": "empty"},
			{ "block": "red", "texture": "res://assets/blocks/blk-red.png", "energy": 3},
			{ "block": "green", "texture": "res://assets/blocks/blk-green.png"}
		],
		
	]
}	

func get_next_position(b: Block, p: Vector2) -> Vector2:
	var x = b.position.x + gap.x
	return Vector2(x, p.y)
	
func build_block(res: String, p: Vector2) -> Block:
	var new_block = block.instantiate()
	var texture = load(res)
	
	new_block.position = p
	new_block.get_node("Sprite").texture = texture
	return new_block			

func load_blocks() -> void:
	var current_position: Vector2 = start_position
	
	for row in LEVEL.get("rows"):
		print("row: ", row)
		for block_cfg in row:
			if block_cfg.get("block") == BLOCK_EMPTY:
				var new_block = block.instantiate()
				new_block.position = current_position
				current_position = get_next_position(new_block, current_position)
				new_block.queue_free()
				print("Instanciate empty block at : ", current_position)
				continue
			else:
				var new_block = build_block(block_cfg.get("texture"), current_position)
				if block_cfg.get("energy"):
					new_block.energy = block_cfg.get("energy")
				current_position = get_next_position(new_block, current_position)
				self.add_child(new_block)
				print("Instanciate block at : ", current_position)
			
		current_position = Vector2(start_position.x, current_position.y + gap.y)
		print("New line, reset position to: ", current_position)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_blocks()
	
