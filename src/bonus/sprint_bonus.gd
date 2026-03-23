extends Node2D

@onready var text_anim: AnimationPlayer = $Node2D/info_bonus/text_anim

@onready var move_y_anim: AnimationPlayer = $Node2D/move_y_anim
@onready var light_effect_anim: AnimationPlayer = $Node2D/sprites/Sprite2D2/light_effect_anim
@onready var fadout_sprit_anim: AnimationPlayer = $Node2D/sprites/fadout_sprit_anim


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if !Global.sprint_unlock:
			Global.sprint_unlock = true
			move_y_anim.stop()
			light_effect_anim.stop()
			fadout_sprit_anim.play("new_animation")
			text_anim.play("new_animation")
