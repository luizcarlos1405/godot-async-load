extends Control


func _on_StartGame_pressed() -> void:
	get_tree().change_scene("res://Game/Game.tscn")
	pass


func _on_Quit_pressed() -> void:
	get_tree().quit()
	pass
