# Godot Async Load

Hi, my name is Luiz and I'm going to teach you how to make a load screen just like this one. I  consider this an intermediary topic as we're going to deal with an asynchronous task. But anyone will be able to follow along and easily reproduce it.

The code for this project is in the description and it's available in the *start* state and the *final* state. If you want to follow along, open the *start* version with Godot.

All right, let's go.

Open the *Menu* scene and open its script *Menu.gd*. You'll notice we change scenes when the *StartGame* button is pressed.

We use the `change_scene` method from the *Scene Tree* to do this.

```python
extends Control

func _on_StartGame_pressed() -> void:
	get_tree().change_scene("res://Game/Game.tscn")
	pass

func _on_Quit_pressed() -> void:
	get_tree().quit()
	pass
```

Now, let's take a look at what's in the *Game* scene. In order to simulate a big load, I generated a big black square image. It might look small here, but it's just because it's scaled-down. If we just change scenes as in the Menu.gd script we'll have to wait for a little.

![readme_assets/game.png](Game Photo)

My computer has an SSD, so if yours have a Hard Drive, this will take even longer.

We will use the class *Thread* that is built-in Godot to load this scene asynchronously. Let's do this. Open the *Menu.gd* script. Then let's create an instance of *Thread.*

```python
var thread: = Thread.new()
```

Now we need a method that the thread can call. This method has to receive one argument and we will make it so this argument is the path of the scene we want to load.

```python
func change_scene_async(path: String):
	var game_scene: PackedScene = load(path)
	get_tree().call_deferred("change_scene_to", game_scene)
```

So, this function receives a path, loads it expecting a *PackedScene* as result, and then defers the scene change to the *SceneTree*. Fairly simple, right?

The `call_deferred` is important because it's not safe to add or remove things from the *Scene Tree* while we're in a thread.

Now, we modify the `_on_StartGame_pressed` callback to use the thread.

```python
func _on_StartGame_pressed() -> void:
	$Loading.show()
	thread.start(self, "change_scene_async", "res://Game/Game.tscn")
```

First, we show our loading spinner. Then, we use thread to call the `change_scene_async` **method.

The first argument of `thread.start` is the instance that has the function we want to call asynchronously. In this case, it's the same we're in. The second is the name of the method to call and the third is the argument to be passed down to the method.

And it's ready. Now if we start the project and click *Start Game* we'll see the spinner while we wait for the *Game* scene to be loaded.

Of course, you can use anything as your loading screen.

That's it for this video, thanks for watching.
