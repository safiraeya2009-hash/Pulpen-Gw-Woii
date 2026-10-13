extends Button

@export_file("*.tscn") var scene_game: String = "res://Scenes/Levels/pengaturan.tscn"

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	get_tree().change_scene_to_file(scene_game)
