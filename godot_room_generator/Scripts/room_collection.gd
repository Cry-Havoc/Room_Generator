class_name RoomCollection
extends Node

@export var roomNames: Array[String] = []
@export var startRoomName: String = "" 
var unusedRoomNames: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready(): 
	ResetRoomNames()
 
func GetRandomRoomName():
	return unusedRoomNames.pop_at(randi_range(0,unusedRoomNames.size()-1)) 

func GetStartRoomName():
	return startRoomName
	
func ResetRoomNames():
	unusedRoomNames.clear()
	unusedRoomNames.append_array(roomNames)
