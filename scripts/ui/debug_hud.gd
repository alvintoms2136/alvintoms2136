extends CanvasLayer

@onready var state_label: Label = $MarginContainer/VBoxContainer/StateLabel
@onready var instability_label: Label = $MarginContainer/VBoxContainer/InstabilityLabel
@onready var corruption_label: Label = $MarginContainer/VBoxContainer/CorruptionLabel
@onready var fps_label: Label = $MarginContainer/VBoxContainer/FPSLabel

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta: float) -> void:
    state_label.text = "Game State: %s" % GameStateManager.get_state_name()
    instability_label.text = "Instability: %.2f" % GameStateManager.instability
    corruption_label.text = "Corruption: %.2f" % GameStateManager.corruption
    fps_label.text = "FPS: %d" % Engine.get_frames_per_second()
