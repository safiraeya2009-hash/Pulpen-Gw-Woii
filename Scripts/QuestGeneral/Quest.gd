@icon("res://Art/Icons/QuestSprite.png")
extends Node
class_name Quest

@export var quest_id : int = 0
@export var quest_name : String = ""
@export var quest_objective : Array[String] = [] # Inisialisasi awal array
@export var quest_reward : int = 0
