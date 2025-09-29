extends CharacterBody2D

const Speed: float = 30000

@export var color: Color = Color("#ffffff")
@export var Debug: bool = false

@export_group("Controls")
@export var Up: String
@export var Right: String
@export var Left: String

var Tagged: bool = false
var Cooldown: float = 0
var No_Floor: float = 0

var Angle: float = 0
var Gravity_Speed: float = 0

func _ready():
	$Poly.color = color


func _physics_process(delta: float) -> void:
	
	if Cooldown > 0:
		Cooldown -= delta
	else:
		Cooldown = 0
	
#-----------------------------MOVEMENT-----------------------------#
	
	
	var num = null
	var jumped: bool = false
	
	velocity.y += 1900 * delta
	
	
	if Input.is_action_pressed(Up) and is_on_floor():
		if Tagged:
			velocity.y -= 1350
		else:
			velocity.y -= 1000
		jumped = true
	if Input.is_action_pressed(Right):
		num = 1
	if Input.is_action_pressed(Left):
		num = -1
		
		
	if num != null:
		if Tagged:
			num *= 1.35
			
		velocity.x = Speed * num * delta
		
		if num == 1 and Angle < 0:
			Gravity_Speed = 0
		if num == -1 and Angle > 0:
			Gravity_Speed = 0
	else:
		velocity.x -= velocity.x * delta * 6
		
		
	if is_on_floor():
		No_Floor = 0
		
		Rotate(Angle)
		
		if !jumped and Angle != 0:

			
			var dir
			if Angle > 0:
				dir = 1
			else:
				dir = -1
				
			velocity = Vector2(velocity.x + (Gravity_Speed * dir), 0).rotated(Angle)
			
			Gravity_Speed += 200 * delta * (abs(sin(Angle)))
		else:
			Gravity_Speed = 0
			
		
	else:
		No_Floor += delta
		if No_Floor > 0.2:
			Rotate(0)


	move_and_slide()


func Area_Entered(area: Area2D) -> void:
	if Tagged:
		var player = area.get_parent()
		
		if player.Cooldown == 0:
			Tagged = false
			player.Tagged = true
			%Marker.follow = player
			Cooldown = 0.1
		
		print("")
		print("Tagger: ", self.name, "  -  Tagged: ", player.name)
		print("")


func Body_Entered(body: Node2D) -> void:
	if body.is_in_group("Platform"):
		Angle = body.global_rotation
		
		if Debug:
			print("")
			print("Set angle to: ", rad_to_deg(Angle))
			print(body.name)
	
	
func Rotate(angle: float):
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_rotation", angle, 0.1)
	
	if Debug:
		print("")
		print("Rotating to: ", rad_to_deg(angle))
	
