extends Area2D

enum QuestFunction {GIVE = 1, UPDATE = 2, COMPLETE = 3}

@export var quest : Quest
@export var type : QuestFunction = QuestFunction.GIVE

var player_quest_tracker : QuestTracker

func _on_body_entered(body):
	if !can_update_quest(body):
		return

	match type:
		QuestFunction.GIVE: give_quest()
		QuestFunction.UPDATE: update_quest()
		QuestFunction.COMPLETE: complete_quest()

	AudioManager.play_sound(AudioManager.QUEST_SOUND, 0, -10)
	queue_free()

func give_quest():
	print("Giving Player a quest!")
	player_quest_tracker.start_new_quest(quest)

func update_quest():
	print("Updating a quest")
	player_quest_tracker.update_quest(quest)

func complete_quest():
	print("Completing a quest!")
	player_quest_tracker.complete_quest(quest)

func can_update_quest(body):
	if !body.is_in_group("Player"):
		return false
		
	player_quest_tracker = body.find_child("QuestTracker") as QuestTracker
		
	if !quest || !player_quest_tracker:
		print("Peringatan: Quest Resource atau QuestTracker tidak ditemukan!")
		return false
		
	return true
