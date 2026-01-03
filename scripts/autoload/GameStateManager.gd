extends Node

enum State { MENU, PLAYING, LEVEL_UP, BOSS_INTRO, GAMEOVER }

var state: State = State.MENU : set = set_state
var instability: float = 0.0
var corruption: float = 0.0

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

func set_state(value: State) -> void:
    if state == value:
        return
    var previous := state
    state = value
    _apply_pause_logic()
    EventBus.emit_state_change(state, previous)

func _apply_pause_logic() -> void:
    var should_pause := state == State.LEVEL_UP
    var tree := get_tree()
    if tree:
        tree.paused = should_pause

func set_instability(value: float) -> void:
    instability = max(value, 0.0)

func set_corruption(value: float) -> void:
    corruption = max(value, 0.0)

func request_state(value: State) -> void:
    set_state(value)

func get_state_name(value: State = state) -> String:
    if value >= 0 and value < State.keys().size():
        return State.keys()[value]
    return \"UNKNOWN\"
