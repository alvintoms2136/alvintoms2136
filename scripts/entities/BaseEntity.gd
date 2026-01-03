extends CharacterBody2D
class_name BaseEntity

@onready var health_component: HealthComponent = $HealthComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent

func _ready() -> void:
    if health_component:
        health_component.owner_entity = self
    if movement_component:
        movement_component.owner_entity = self
    if hitbox_component:
        hitbox_component.owner_entity = self

func take_damage(amount: int) -> void:
    if health_component:
        health_component.apply_damage(amount)
