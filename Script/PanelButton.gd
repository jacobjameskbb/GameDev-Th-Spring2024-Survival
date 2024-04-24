extends Button

var button_id

signal Cbutton_up(Cbutton_pressed)

func _on_button_up():
	emit_signal('Cbutton_up',self)
