extends Node2D
# Member variables for the 3D scene and cameras and the 2D sprites
var playerScene = preload("res://player.scn");
var playerSceneInstance;
var camera1 = null
var camera2 = null
var sprite = null
var viewport_sprite1 = null
var viewport_sprite2 = null
# Constants and variables for the 2D sprite animation
const MAX_FRAME_FOR_SPRITE = 4
const FRAME_SWITCH_TIME = 0.2
var frame_switch_timer = 0

func _ready():
	# Get the 2D sprite
	sprite = get_node("Sprite")
	# Get a shared player scene instance
	playerSceneInstance = playerScene.instance();
	self.add_child(playerSceneInstance);
	# Get the cameras
	camera1 = playerSceneInstance.get_node("Viewport/Camera")
	camera2 = playerSceneInstance.get_node("Viewport2/Camera2")
	# Get the sprites
	viewport_sprite1 = get_node("Viewport_Sprite")
	viewport_sprite2 = get_node("Viewport_Sprite2")
	# Assign the sprite's texture to the viewport texture
	camera1.get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	camera2.get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	# Assign the camera viewport textures to the sprites
	viewport_sprite1.texture = camera1.get_viewport().get_texture()
	viewport_sprite2.texture = camera2.get_viewport().get_texture()

func _process(delta):
	# Control the 2D sprite animation (loop from frame 0 to MAX)
	frame_switch_timer += delta
	if frame_switch_timer >= FRAME_SWITCH_TIME:
		frame_switch_timer -= FRAME_SWITCH_TIME
		sprite.frame += 1
	if sprite.frame > MAX_FRAME_FOR_SPRITE:
		sprite.frame = 0
	# Control movement of the individual cameras in the 3D scene
	if Input.is_action_pressed("ui_left"):
		playerSceneInstance.get_node("Viewport/Camera").rotate_z(0.1);
	elif Input.is_action_pressed("ui_right"):
		playerSceneInstance.get_node("Viewport/Camera").rotate_z(-0.1);
	if Input.is_action_pressed("ui_up"):
		playerSceneInstance.get_node("Viewport2/Camera2").rotate_z(0.1);
	elif Input.is_action_pressed("ui_down"):
		playerSceneInstance.get_node("Viewport2/Camera2").rotate_z(-0.1);
	# Control the movement of the player 3D object
	if Input.is_action_pressed("ui_page_up"):
		playerSceneInstance.get_node("Armature").rotate_y(0.1);
	elif Input.is_action_pressed("ui_page_down"):
		playerSceneInstance.get_node("Armature").rotate_y(-0.1);