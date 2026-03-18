extends Node

var nb_fractal:int = 0
var door_opened:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().reload_current_scene()
		nb_fractal = 0
		door_opened = false
		
		
		
		
		
