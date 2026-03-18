extends Node2D
@onready var player: Player = %Player

@onready var ground: Sprite2D = $lvl1/ground

@onready var zoomcam: PhantomCamera2D = $zoomcam
@onready var camoffesetbottom: PhantomCamera2D = $camoffesetbottom
@onready var camoffesetbottom_2: PhantomCamera2D = %camoffesetbottom2

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var canvas_modulate: CanvasModulate = $CanvasModulate

@onready var intro: Node2D = $intro
@onready var lvl_1: Node2D = $lvl1
@onready var lvl_2: Node2D = $lvl2
@onready var lvl_3: Node2D = $lvl3
@onready var paralaxmulticlolor: Parallax2D = $lvl1/paralaxmulticlolor
@onready var tentacles: Node2D = $void/tentacles

var lvl_2_loaded:bool = false

func duplicate_room1(offset_x):
	var r = ground.duplicate()
	r.position.x = r.position.x + offset_x 
	r.z_index = r.z_index -1
	$".".add_child(r)  

func creer_ground():
	var len = 0.274 * 13902
	for i in range(10):
		duplicate_room1(i*len)
	ground.hide()
	ground.process_mode = Node.PROCESS_MODE_DISABLED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player.global_position = Vector2(0,-2876.0)
	creer_ground()

	canvas_modulate.hide()
	player.hide()
	player.process_mode = Node.PROCESS_MODE_DISABLED
	lvl_2.hide()
	lvl_2.process_mode = Node.PROCESS_MODE_DISABLED
	lvl_3.hide()
	lvl_3.process_mode = Node.PROCESS_MODE_DISABLED
	paralaxmulticlolor.hide()

func music_player_logic():
	if player.position.x > 14081 and player.position.y > 372 :
		if audio_stream_player.get_stream_playback().get_current_clip_index() !=1:
			audio_stream_player.get_stream_playback().switch_to_clip_by_name("noise")
	
	if player.position.x < -3562:
		if audio_stream_player.get_stream_playback().get_current_clip_index() !=1:
			audio_stream_player.get_stream_playback().switch_to_clip_by_name("noise")
			
	if player.position.x > -3562:
		if lvl_2_loaded :
			if audio_stream_player.get_stream_playback().get_current_clip_index() !=2:
				audio_stream_player.get_stream_playback().switch_to_clip_by_name("stimulation")
				audio_stream_player.volume_db=-10
	
func die_logic():
	if player.global_position.y > 5000:
		player.respawn()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.is_on_floor():
		intro.hide()
		intro.process_mode = Node.PROCESS_MODE_DISABLED

	if !audio_stream_player.playing:
		audio_stream_player.play()

		
	music_player_logic()
	
	die_logic()

#CAMERA LOGIC
func _on_zoom_zone_body_entered(body: Node2D) -> void:
	if body is Player : zoomcam.priority = 10
func _on_zoom_zone_body_exited(body: Node2D) -> void:
	if body is Player : zoomcam.priority = 0
func _on_no_bottom_offset_zone_body_entered(body: Node2D) -> void:
	if body is Player : camoffesetbottom.priority = 10
func _on_no_bottom_offset_zone_body_exited(body: Node2D) -> void:
	if body is Player : 
		camoffesetbottom.priority = 0
		camoffesetbottom_2.priority = 0
#CAMERA LOGIC FOR LVL2
func _on_no_offset_zone_lvl_2_body_entered(body: Node2D) -> void:
	if body is Player : camoffesetbottom.priority = 10
func _on_no_offset_zone_lvl_2_body_exited(body: Node2D) -> void:
	if body is Player : 
		camoffesetbottom.priority = 0
		camoffesetbottom_2.priority = 0

func _on_cinematic_animation_finished() -> void:
	canvas_modulate.show()
	player.show()
	player.process_mode = Node.PROCESS_MODE_INHERIT

func _on_change_scene_whenvoid_body_entered(body: Node2D) -> void:
	if body is Player:
		if !lvl_2_loaded:
			lvl_2_loaded = true
			
			lvl_2.show()
			lvl_2.process_mode = Node.PROCESS_MODE_INHERIT
			lvl_3.show()
			lvl_3.process_mode = Node.PROCESS_MODE_INHERIT
			lvl_1.hide()
			lvl_1.process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_change_scene_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		lvl_1.show()
		lvl_1.process_mode = Node.PROCESS_MODE_INHERIT
		lvl_2.hide()
		lvl_2.process_mode = Node.PROCESS_MODE_DISABLED
		
		lvl_2_loaded = false
		
		paralaxmulticlolor.show()
