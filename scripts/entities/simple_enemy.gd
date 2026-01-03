extends "res://scripts/entities/base_entity.gd"
class_name SimpleEnemy

@export var target_path: NodePath

var target: Node2D

func _ready() -> void:
    super._ready()
    if target_path != NodePath():
        target = get_node_or_null(target_path)

func _physics_process(_delta: float) -> void:
    if GameStateManager.state != GameStateManager.State.PLAYING:
        return
    if target and movement_component:
        movement_component.seek_target(target.global_position)
