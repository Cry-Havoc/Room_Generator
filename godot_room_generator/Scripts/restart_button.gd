class_name RestartButton
extends Button

@onready var roomGenerator = $"../../RoomGenerator"

func _on_pressed():
	roomGenerator.Restart() 
