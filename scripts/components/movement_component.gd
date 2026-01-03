extends Node
class_name MovementComponent

@export var speed: float = 200.0
var owner_entity: BaseEntity

func move_with_input(input_vector: Vector2) -> void:
    if owner_entity == null:
        return
    var direction := input_vector.normalized()
    owner_entity.velocity = direction * speed
    owner_entity.move_and_slide()

func seek_target(target_position: Vector2) -> void:
    if owner_entity == null:
        return
    var direction := (target_position - owner_entity.global_position).normalized()
    owner_entity.velocity = direction * speed
    owner_entity.move_and_slide()
