extends Node

signal game_state_changed(new_state, previous_state)
signal data_loaded(dataset_name)
signal data_load_failed(dataset_name, reason)
signal schema_validation_failed(dataset_name, missing_keys)

func emit_state_change(new_state, previous_state) -> void:
    emit_signal("game_state_changed", new_state, previous_state)

func emit_data_loaded(dataset_name: String) -> void:
    emit_signal("data_loaded", dataset_name)

func emit_data_failed(dataset_name: String, reason: String) -> void:
    emit_signal("data_load_failed", dataset_name, reason)

func emit_schema_failed(dataset_name: String, missing_keys: Array) -> void:
    emit_signal("schema_validation_failed", dataset_name, missing_keys)
