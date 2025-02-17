extends CanvasLayer

@onready var AP : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fadeIn()

func fadeIn():
	AP.play('fade_in')

func fadeOut():
	pass
