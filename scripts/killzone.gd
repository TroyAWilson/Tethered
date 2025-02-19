extends Area2D

@onready var game : Node2D
@onready var player : CharacterBody2D = %Player

func _ready() -> void:
	game = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		game.gameover = true
