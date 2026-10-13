extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine
const DEATH_SCREEN = preload("res://Scenes/Misc/DeathScreen.tscn")

@onready var label_waktu = $Camera2D/LabelWaktu 
@onready var timer = $Timer

func _ready():
	# Memanggil _ready() dari CharacterBase (jika ada)
	super() 
	
	timer.wait_time = 350.0
	timer.one_shot = true
	timer.start()

# Ubah _delta menjadi delta dan panggil super(delta)
func _process(delta):
	# Memanggil _process() dari CharacterBase agar FSM dan pergerakan tidak rusak
	super(delta) 
	
	var waktu_tersisa = int(timer.time_left)
	var menit = waktu_tersisa / 60
	var detik = waktu_tersisa % 60
	
	label_waktu.text = "%02d:%02d" % [menit, detik]

func _die():
	super()
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://BadEnding.tscn")
