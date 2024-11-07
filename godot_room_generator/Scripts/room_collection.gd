class_name RoomCollection
extends Node

@export var roomNames: Array[String] = []
var unusedRoomNames: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready(): 
	unusedRoomNames.append_array(roomNames)
 
func GetRandomRoomName():
	return unusedRoomNames.pop_at(randi_range(0,unusedRoomNames.size()-1)) 
