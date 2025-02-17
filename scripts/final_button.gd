extends Area2D

var successScreen = preload("res://scenes/game_win.tscn")

func _on_body_entered(body: Node2D) -> void:
	#In a perfect world this gets expanded on and maybe has a little jingle/animation
	var game_win = successScreen.instantiate()
	var UI = $"../UI"
	UI.add_child(game_win)
	Engine.time_scale = 0
