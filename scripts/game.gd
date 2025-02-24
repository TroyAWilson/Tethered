extends Node2D

@onready var player : CharacterBody2D = %Player
@onready var ui : CanvasLayer = $UI
var pauseScreen = preload("res://scenes/game_pause.tscn")
var gameOverScreen = preload("res://scenes/game_over.tscn")
var paused := false
var gameover := false
var ps : Object
var gameOverInst : Object = null

func _ready() -> void:
	changeGravity(0.1)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta: float) -> void:
	
	if gameover and gameOverInst == null:
		gameOverInst = gameOverScreen.instantiate()
		ui.add_child(gameOverInst)
		Engine.time_scale = 0
	
	if Input.is_action_just_pressed("pause"):
		if paused:
			Engine.time_scale = 1
			ps.queue_free()
		else:
			ps = pauseScreen.instantiate()
			ui.add_child(ps)
			Engine.time_scale = 0
		paused = !paused
	
func changeGravity(gravityAcc : float = 0.5):
	#gravityAcc 0 - 1 is lower gravity, above 1 is higher gravity
	player.gravityAcc = gravityAcc
