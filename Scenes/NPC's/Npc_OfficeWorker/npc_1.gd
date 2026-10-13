extends Area2D

#TextBubble
var talking = false
@export var speech : Label
@export var line1 = []

@export var show_text_duration : float = 1.0
@export var silence_duration : float = 1.0

# Referensi ke node AudioStreamPlayer2D (Pastikan posisinya benar)
@onready var audio_player = $AudioStreamPlayer2D

func _ready():
	# Pengaman: pastikan Label speech sudah diisi di Inspector
	if speech != null:
		speech.text = ""

#region Signal Entering & Exiting

func _on_body_entered(body):
	if body.is_in_group("Player") and not talking:
		talk_tween()
		
		# Pengaman: pastikan line1 ada isinya dan speech tidak kosong
		if line1.size() > 0 and speech != null:
			speech.text = line1[randi() % line1.size()]
		
		# Putar suara saat player masuk
		if audio_player != null:
			audio_player.play()

func _on_body_exited(body):
	if body.is_in_group("Player") and talking:
		await get_tree().create_timer(show_text_duration).timeout 
		
		# PENGAMAN 1: Cek apakah NPC ini masih ada di dalam game setelah menunggu
		if not is_inside_tree() or speech == null:
			return # Hentikan fungsi di sini agar tidak crash
			
		speech.text = "Ada ada saja"
		
		await get_tree().create_timer(silence_duration).timeout 
		
		# PENGAMAN 2: Cek lagi sebelum menghapus teks
		if not is_inside_tree() or speech == null:
			return
			
		speech.text = ""
		talking = false
		
#endregion

#Animate the NPC talking with some simple tweening
func talk_tween():
	talking = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.2)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.2)
	tween.tween_property(self, "scale", Vector2.ONE, 0.2)
