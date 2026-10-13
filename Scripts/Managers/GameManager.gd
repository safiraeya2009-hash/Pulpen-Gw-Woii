extends Node

var money = 0

func reset_money():
	money = 0

func add_money(addmoney : int):
	money += addmoney

func load_next_level(next_scene):
	# Validasi awal jika variabel yang dikirim ternyata null
	if next_scene == null:
		push_error("Error: Target scene bernilai null/kosong!")
		return

	if next_scene is String:
		get_tree().change_scene_to_file(next_scene)
	elif next_scene is PackedScene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		push_error("Scene tujuan tidak valid!")

func load_same_level():
	get_tree().reload_current_scene()
