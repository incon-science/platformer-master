extends Node2D

@onready var locklayer: CanvasLayer = $locklayer
@onready var line_edit: LineEdit = $locklayer/LineEdit
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var opened : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _input(event):
	pass


func _on_openlockzone_body_entered(body: Node2D) -> void:
	if body is Player :
		if !opened:
			locklayer.show()
			line_edit.grab_focus()

func _on_openlockzone_body_exited(body: Node2D) -> void:
	locklayer.hide()


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text == "1972":
		animation_player.play("up_door")
		locklayer.hide()
		opened = true
	if new_text.length()>4 :
		line_edit.clear()
