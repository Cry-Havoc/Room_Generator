class_name MapButton
extends Button

@onready var roomGenerator = $"../../RoomGenerator"

func _on_pressed():
	roomGenerator.Start2DMap()
