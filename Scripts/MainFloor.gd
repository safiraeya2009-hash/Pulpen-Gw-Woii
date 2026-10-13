extends Area2D

@onready var label = $Label

# Preload langsung ke scene Secret
const TARGET_SCENE = preload("res://Scenes/Levels/Secret.tscn")

func _ready():
	label.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("Enter") and label.visible:
		GameManager.load_next_level(TARGET_SCENE)
func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.visible = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.visible = false
