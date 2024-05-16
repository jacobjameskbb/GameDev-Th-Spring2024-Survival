extends Control

func _process(_delta):
	if Input.is_action_just_released("menu"):
		if $PopUpMenu.visible:
			get_tree().paused = false
			$PopUpMenu.visible = false
		elif $Settings.visible:
			get_tree().paused = false
			$Settings.visible = false
			apply_volume()
		else:
			get_tree().paused = true
			$PopUpMenu.visible = true
	
	if Global.Player.dead:
		$"YourDead!Label".visible = true
	
	position = Global.Player.position - self.size / 2.0

func apply_volume():
	for audioplayer in get_parent().list_of_audiostreamplayers:
		audioplayer.set_volume_db($Settings/Volume.value)
		if $Settings/Volume.value == $Settings/Volume.min_value:
			audioplayer.set_volume_db($Settings/Volume.value - 80)

func _on_quit_button_up():
	get_tree().quit()

func _on_settings_button_up():
	$PopUpMenu.visible = false
	$Settings.visible = true

func _on_back_button_button_up():
	$PopUpMenu.visible = true
	$Settings.visible = false
	apply_volume()

func _on_back_to_game_button_button_up():
	$PopUpMenu.visible = false
	get_tree().paused = false
