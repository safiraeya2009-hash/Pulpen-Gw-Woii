extends Area2D

var talking = false
var is_player_inside = false
var waiting_for_choice = false # Penanda bahwa player sedang di tahap memilih

@export var speech : Label
@export var line1 : Array[String] = []

@export var show_text_duration : float = 1.0
@export var silence_duration : float = 1.0

@onready var choice_container = $HBoxContainer
@onready var accept_button = $HBoxContainer/Menerima
@onready var decline_button = $HBoxContainer/Menolak

func _ready():
	speech.text = ""
	
	if choice_container:
		choice_container.visible = false
		
	if accept_button and not accept_button.pressed.is_connected(_on_accept_pressed):
		accept_button.pressed.connect(_on_accept_pressed)
	if decline_button and not decline_button.pressed.is_connected(_on_decline_pressed):
		decline_button.pressed.connect(_on_decline_pressed)

func _process(_delta):
	# Memeriksa input keyboard saat menu pilihan muncul
	if waiting_for_choice and is_player_inside:
		if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_1) or Input.is_key_pressed(KEY_E):
			_on_accept_pressed()
		elif Input.is_action_just_pressed("ui_cancel") or Input.is_key_pressed(KEY_2) or Input.is_key_pressed(KEY_Q):
			_on_decline_pressed()

#region Signal Entering & Exiting

func _on_body_entered(body):
	if body.is_in_group("Player"):
		is_player_inside = true
		if not talking:
			start_dialogue()

func _on_body_exited(body):
	if body.is_in_group("Player"):
		is_player_inside = false
		waiting_for_choice = false
		if choice_container:
			choice_container.visible = false
		
		await get_tree().create_timer(show_text_duration).timeout
		if not is_player_inside:
			speech.text = "Byeee MUAHH"
			await get_tree().create_timer(silence_duration).timeout
			if not is_player_inside:
				speech.text = ""
				talking = false

#endregion

func start_dialogue():
	talking = true
	
	for line in line1:
		if not is_player_inside:
			return
			
		talk_tween()
		speech.text = line
		await get_tree().create_timer(3.0).timeout

	if is_player_inside and choice_container:
		choice_container.visible = true
		waiting_for_choice = true # Aktifkan pendeteksi tombol keyboard

func _on_accept_pressed():
	waiting_for_choice = false
	choice_container.visible = false
	speech.text = "Yeay! I LOVE YOUUU DARLING. Bolehkah aku menghisap darahmu?"
	talk_tween()

func _on_decline_pressed():
	waiting_for_choice = false
	choice_container.visible = false
	speech.text = "mmmm MUAHHH I LOVE YOUU ADIT. Aku lapar apakh aku boleh menghisap darahmu?"
	talk_tween()

func talk_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.1)
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)
