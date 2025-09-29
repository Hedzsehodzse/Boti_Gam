extends Polygon2D


var follow: Node


func _process(_delta: float) -> void:
	if follow != null:
		global_position = follow.global_position + Vector2(0, -70)
