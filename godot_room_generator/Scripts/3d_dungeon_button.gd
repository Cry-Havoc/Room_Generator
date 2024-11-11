class_name DungeonButton
extends Button

@onready var roomGenerator = $"../../RoomGenerator"

func _on_pressed():
	roomGenerator.Start3DDungeon()
