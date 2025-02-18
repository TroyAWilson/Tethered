extends AnimatableBody2D

func _ready() -> void:
	add_to_group('grapple_targets') #necessary for moving platforms
