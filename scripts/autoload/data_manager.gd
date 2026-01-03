extends Node

const REQUIRED_KEYS := ["schema_version", "entries"]

var weapons: Dictionary = {}
var passives: Dictionary = {}
var enemies: Dictionary = {}
var evolutions: Dictionary = {}
var scaling: Dictionary = {}
var tuning_mods: Dictionary = {}
var pattern_modifiers: Dictionary = {}

const DATASETS := {
    "weapons": "res://data/weapons.json",
    "passives": "res://data/passives.json",
    "enemies": "res://data/enemies.json",
    "evolutions": "res://data/evolutions.json",
    "scaling": "res://data/scaling.json",
    "tuning_mods": "res://data/tuning_mods.json",
    "pattern_modifiers": "res://data/pattern_modifiers.json"
}

func _ready() -> void:
    _load_all_datasets()

func _load_all_datasets() -> void:
    for dataset_name in DATASETS.keys():
        _load_dataset(dataset_name, DATASETS[dataset_name])

func _load_dataset(dataset_name: String, path: String) -> void:
    var parsed: Dictionary = _load_json(path)
    if parsed.is_empty():
        EventBus.emit_data_failed(dataset_name, "Failed to parse %s" % path)
        return

    var missing_keys := []
    for key in REQUIRED_KEYS:
        if not parsed.has(key):
            missing_keys.append(key)
    if missing_keys.size() > 0:
        EventBus.emit_schema_failed(dataset_name, missing_keys)
        push_error("[%s] Missing required keys: %s" % [dataset_name, ", ".join(missing_keys)])
        return

    if typeof(parsed["schema_version"]) != TYPE_INT:
        EventBus.emit_schema_failed(dataset_name, ["schema_version must be int"])
        push_error("[%s] schema_version must be an integer" % dataset_name)
        return

    var entries: Dictionary = parsed.get("entries", {})
    if typeof(entries) != TYPE_DICTIONARY:
        EventBus.emit_schema_failed(dataset_name, ["entries must be a dictionary"])
        push_error("[%s] entries must be a dictionary" % dataset_name)
        return
    match dataset_name:
        "weapons":
            weapons = entries
        "passives":
            passives = entries
        "enemies":
            enemies = entries
        "evolutions":
            evolutions = entries
        "scaling":
            scaling = entries
        "tuning_mods":
            tuning_mods = entries
        "pattern_modifiers":
            pattern_modifiers = entries
        _:
            pass

    EventBus.emit_data_loaded(dataset_name)

func _load_json(path: String) -> Dictionary:
    if not FileAccess.file_exists(path):
        push_error("[DataManager] File does not exist: %s" % path)
        return {}

    var text := FileAccess.get_file_as_string(path)
    var result = JSON.parse_string(text)
    if typeof(result) != TYPE_DICTIONARY:
        push_error("[DataManager] Invalid JSON content in %s" % path)
        return {}
    return result
