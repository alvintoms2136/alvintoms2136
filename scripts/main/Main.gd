extends Node2D

const INPUT_MAP := {
    "move_left": KEY_A,
    "move_right": KEY_D,
    "move_up": KEY_W,
    "move_down": KEY_S,
    "trigger_level_up": KEY_L
}

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    _ensure_input_actions()
    GameStateManager.set_state(GameStateManager.State.PLAYING)
    _log_dataset_summary()

func _physics_process(delta: float) -> void:
    if Input.is_action_just_pressed("trigger_level_up"):
        if GameStateManager.state == GameStateManager.State.LEVEL_UP:
            GameStateManager.set_state(GameStateManager.State.PLAYING)
        else:
            GameStateManager.set_state(GameStateManager.State.LEVEL_UP)
    if GameStateManager.state == GameStateManager.State.PLAYING:
        GameStateManager.set_instability(GameStateManager.instability + delta * 0.5)
        GameStateManager.set_corruption(GameStateManager.corruption + delta * 0.25)

func _ensure_input_actions() -> void:
    for action in INPUT_MAP.keys():
        if not InputMap.has_action(action):
            InputMap.add_action(action)
        var event := InputEventKey.new()
        event.physical_keycode = INPUT_MAP[action]
        event.keycode = INPUT_MAP[action]
        if not _action_has_event(action, event):
            InputMap.action_add_event(action, event)

    _add_arrow_keys()

func _add_arrow_keys() -> void:
    var extra := {
        "move_left": KEY_LEFT,
        "move_right": KEY_RIGHT,
        "move_up": KEY_UP,
        "move_down": KEY_DOWN
    }
    for action in extra.keys():
        var event := InputEventKey.new()
        event.physical_keycode = extra[action]
        event.keycode = extra[action]
        if not _action_has_event(action, event):
            InputMap.action_add_event(action, event)

func _action_has_event(action: StringName, target_event: InputEventKey) -> bool:
    for existing_event in InputMap.action_get_events(action):
        if existing_event is InputEventKey and existing_event.physical_keycode == target_event.physical_keycode:
            return true
    return false

func _log_dataset_summary() -> void:
    var message := "Data Loaded: weapons=%d, passives=%d, enemies=%d" % [
        DataManager.weapons.size(),
        DataManager.passives.size(),
        DataManager.enemies.size()
    ]
    print(message)
