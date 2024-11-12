class_name BackButton
extends Button

@onready var roomGenerator =  $"../../RoomGenerator"

func _on_pressed():
	roomGenerator.BackToGenerator()
