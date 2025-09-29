extends Node2D


func _ready() -> void:
	var num = randi_range(0, %Players.get_child_count() - 1)
	var player = %Players.get_child(num)
	player.Tagged = true
	%Marker.follow = player

#func _process(delta: float) -> void:
	#pass
