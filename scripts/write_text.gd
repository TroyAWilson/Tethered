extends Label

var onscreen := false
var count := 0 #slows down the text typing
	
	
func _process(delta: float) -> void:
	if onscreen and count%3 == 0:
		visible_characters += 1
	count += 1	

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	onscreen = true

func _on_timer_timeout() -> void:
	print('test')
