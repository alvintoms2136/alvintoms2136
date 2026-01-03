extends Node
class_name HealthComponent

@export var max_health: int = 100
var current_health: int
var owner_entity: BaseEntity

func _ready() -> void:
    current_health = max_health

func apply_damage(amount: int) -> void:
    current_health = max(current_health - amount, 0)
    if current_health == 0:
        _on_death()

func heal(amount: int) -> void:
    current_health = min(current_health + amount, max_health)

func _on_death() -> void:
    if owner_entity:
        owner_entity.queue_free()
