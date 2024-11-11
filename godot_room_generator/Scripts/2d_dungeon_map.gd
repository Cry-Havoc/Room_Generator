class_name DungeonMap
extends Node2D

@onready var roomGenerator = $"../RoomGenerator" 

var dungeonMapStarted = false 
var visibleRooms = []
var roomUIs = []
 
# Called when the node enters the scene tree for the first time.
func StartDungeonMap(): 
	visibleRooms.clear()
	visibleRooms.append(roomGenerator.currentRoom)
	dungeonMapStarted = true
	PrintRoom(roomGenerator.currentRoom) 
	
func LeaveDungeonMap():
	visibleRooms.clear()
	
	for roomUI : RoomUIElement in roomUIs: 
		roomUI.queue_free()
		
	roomUIs.clear()  
	dungeonMapStarted = false
	
func PrintRoom(roomData : RoomNode):   
	 
	var newRoom = preload("res://Scenes/RoomUI.tscn").instantiate() 
	add_child(newRoom)
	roomUIs.append(newRoom)
	newRoom.roomData = roomData
	newRoom.generator = roomGenerator
	newRoom.dungeonMap = self 
	
	var centerPos = get_viewport_rect().size / 2 
	newRoom.position.x = centerPos.x/2 + roomData.roomCoordinates.x * 75
	newRoom.position.y = centerPos.y/2 + roomData.roomCoordinates.y * 75
	
	for roomUI : RoomUIElement in roomUIs: 
		roomUI.UpdateVisibility()
	
	
					
	#	for roomUI : RoomUI in roomUIs:
			#roomUI.UpdateVisibility()
	
	 	
func _input(event):
	if(not dungeonMapStarted):
		return 
		
	if event.is_action_pressed("North"):
		if(roomGenerator.currentRoom.CanGoNorth()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomNorth() 
			visibleRooms.append(roomGenerator.currentRoom)
			PrintRoom(roomGenerator.currentRoom) 
	elif event.is_action_pressed("South"):
		if(roomGenerator.currentRoom.CanGoSouth()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomSouth() 
			visibleRooms.append(roomGenerator.currentRoom) 
			PrintRoom(roomGenerator.currentRoom) 
	elif event.is_action_pressed("West"):
		if(roomGenerator.currentRoom.CanGoWest()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomWest() 
			visibleRooms.append(roomGenerator.currentRoom) 
			PrintRoom(roomGenerator.currentRoom) 
	elif event.is_action_pressed("East"):
		if(roomGenerator.currentRoom.CanGoEast()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomEast()  
			visibleRooms.append(roomGenerator.currentRoom) 
			PrintRoom(roomGenerator.currentRoom)  

			
