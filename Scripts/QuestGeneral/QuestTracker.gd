extends Node
class_name QuestTracker

# 1. Deklarasi Variabel Utama
const QUESTRESOURCE = preload("res://Scenes/QuestTemplate.tscn")

var current_quest_step : int = 0
var quest_length : int = 0
var current_quest : Quest

@export var quest_info : Label
@export var quest_announcement : Label

func _ready():
	if quest_announcement:
		quest_announcement.text = ""
	
	# Instantiate template quest dasar
	var quest_instance = QUESTRESOURCE.instantiate()
	add_child(quest_instance)
	current_quest = quest_instance as Quest

# 2. Fungsi Memulai Quest Baru
func start_new_quest(new_quest : Quest):
	if new_quest == null:
		print("Error: new_quest bernilai null!")
		return
		
	if new_quest.quest_objective.is_empty():
		print("Peringatan: Quest objective pada " + new_quest.quest_name + " kosong!")
		return

	quest_length = new_quest.quest_objective.size()
	current_quest_step = 0
	
	# Salin data dari new_quest ke current_quest
	current_quest.quest_id = new_quest.quest_id
	current_quest.quest_name = new_quest.quest_name
	current_quest.quest_objective = new_quest.quest_objective.duplicate(true)
	current_quest.quest_reward = new_quest.quest_reward

	# Tampilkan teks objective di UI
	update_quest_ui()
	announce_quest(new_quest.quest_name, 2.0)

# 3. Fungsi Update Quest
func update_quest(source_quest : Quest):
	if !source_quest or !current_quest:
		return
		
	if source_quest.quest_id != current_quest.quest_id:
		return
	
	if current_quest_step + 1 >= current_quest.quest_objective.size():
		print("Sudah di tahap terakhir quest.")
		return
		
	current_quest_step += 1
	update_quest_ui()
	announce_quest("Quest Updated!", 1.5)

# 4. Fungsi Menyelesaikan Quest
func complete_quest(quest : Quest):
	GameManager.add_money(quest.quest_reward)
	announce_quest("Quest Completed!", 3.0)
	if quest_info:
		quest_info.text = ""

# 5. Helper UI
func update_quest_ui():
	if quest_info and current_quest and current_quest_step < current_quest.quest_objective.size():
		var objective_text = current_quest.quest_objective[current_quest_step]
		quest_info.text = current_quest.quest_name + ":\n" + objective_text

func announce_quest(text : String, time : float):
	if !quest_announcement:
		return
		
	quest_announcement.text = text
	quest_announcement.modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(quest_announcement, "modulate:a", 1.0, 0.5)
	tween.tween_interval(time)
	tween.tween_property(quest_announcement, "modulate:a", 0.0, 0.5)
	await tween.finished
	quest_announcement.text = ""
