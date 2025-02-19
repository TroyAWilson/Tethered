extends Label

#This code should be made into a class or reusable component of some kind because
# it's redundant wit the other Label code.

var onscreen := false
	
func _process(delta: float) -> void:
	if onscreen:
		visible_characters += 1

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	onscreen = true
