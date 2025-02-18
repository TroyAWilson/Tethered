extends Area2D

#GravChangeArea requires a collision shape to be attatched on declaration as well
#	as that collision shape to have a metadata called "gravChange" which is a float

@onready var collisionShape : CollisionShape2D

func _ready() -> void:
	collisionShape = get_child(0)

func _on_body_entered(body: Node2D) -> void:
	print('entered')
	var gravChange = collisionShape.get_meta('gravChange')
	get_parent().changeGravity(gravChange)
	collisionShape.queue_free()
