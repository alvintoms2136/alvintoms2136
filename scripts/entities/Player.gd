extends "res://scripts/entities/BaseEntity.gd"
class_name Player

@export var input_actions := {
    "left": "move_left",
    "right": "move_right",
    "up": "move_up",
    "down": "move_down"
}

func _physics_process(_delta: float) -> void:
    if GameStateManager.state != GameStateManager.State.PLAYING:
        return
    var input_vector := Input.get_vector(input_actions["left"], input_actions["right"], input_actions["up"], input_actions["down"])
    if movement_component:
        movement_component.move_with_input(input_vector)
