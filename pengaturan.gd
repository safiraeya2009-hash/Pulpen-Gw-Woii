extends Node2D

#@onready var button = $Button

func _ready() -> void:
	#button.pressed.connect(_on_button_pressed)
	pass
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tampilan_awal.tscn")
