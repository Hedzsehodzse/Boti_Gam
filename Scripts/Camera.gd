extends Camera2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var pos = Vector2.ZERO
	var x: float = 1
	var y: float = 1
	
	for player in %Players.get_children():
		pos += player.global_position
		
		var x_num = abs(player.global_position.x - global_position.x) / 960
		var y_num = abs(player.global_position.y - global_position.y) / 540
		
		if x_num > x:
			x = x_num
		if y_num > y:
			y = y_num
			
	if x > y:
		zoom = Vector2(1 / x, 1 / x) * 0.9
	else:
		zoom = Vector2(1 / y, 1 / y) * 0.9
	
	global_position = pos / %Players.get_child_count()
	
	global_position.y -= 400 * 1 / zoom.x
	
	
