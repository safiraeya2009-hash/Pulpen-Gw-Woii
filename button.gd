extends Button

const NEXT_SCENE = "res://Scenes/video_stream_player.tscn"

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	get_tree().change_scene_to_file(NEXT_SCENE)
