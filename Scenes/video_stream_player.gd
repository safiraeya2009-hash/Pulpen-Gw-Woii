extends VideoStreamPlayer

@export_file("*.tscn") var scene_selanjutnya: String = "res://Scenes/Levels/MainFloor.tscn"

func _ready() -> void:
	play()
	finished.connect(_on_video_finished)

func _input(event: InputEvent) -> void:
	# Mendeteksi jika pemain menekan tombol Spasi
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_SPACE:
		_pindah_scene()

func _on_video_finished() -> void:
	# Otomatis berpindah saat video selesai diputar
	_pindah_scene()

# Fungsi terpisah agar logika perpindahan scene rapi dan tidak duplikat
func _pindah_scene() -> void:
	get_tree().change_scene_to_file(scene_selanjutnya)
