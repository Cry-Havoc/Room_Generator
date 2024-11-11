class_name RoomUIElement
extends Node2D
 
var roomData : RoomNode
var generator : RoomGen
var dungeonMap : DungeonMap

@onready var myText = $Label
@onready var northDoor = $Label/NorthDoor
@onready var southDoor = $Label/SouthDoor
@onready var westDoor = $Label/WestDoor
@onready var eastDoor = $Label/EastDoor
@onready var backGround =  $Label/RoomBackGroud

  
func UpdateVisibility():
	  
	if(roomData in dungeonMap.visibleRooms): 
		self.visible = true
		myText.text = roomData.roomName;
		northDoor.visible = roomData.CanGoNorth()
		southDoor.visible = roomData.CanGoSouth()
		westDoor.visible = roomData.CanGoWest()
		eastDoor.visible = roomData.CanGoEast()
		
		if(roomData == generator.currentRoom):
			backGround.modulate = Color(1, 1, 0.5)  
		else:
			backGround.modulate = Color(1, 1, 1)  
		
	else:
		self.visible = false
	
