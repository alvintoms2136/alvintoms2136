extends Area2D
class_name HitboxComponent

var owner_entity: BaseEntity

func _ready() -> void:
    monitoring = true
    monitorable = true
