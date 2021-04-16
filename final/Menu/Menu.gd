extends Control

var thread: = Thread.new()


func change_scene_async(path: String):
	var game_scene: PackedScene = load(path)
	get_tree().call_deferred("change_scene_to", game_scene)


func _on_StartGame_pressed() -> void:
	$Loading.show()
	thread.start(self, "change_scene_async", "res://Game/Game.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()
