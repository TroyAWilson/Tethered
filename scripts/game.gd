extends Node2D

@onready var player : CharacterBody2D = %Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	changeGravity(0.1)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeGravity(gravityAcc : float = 0.5):
	#gravityAcc 0 - 1 is lower gravity, above 1 is higher gravity
	player.gravityAcc = gravityAcc
