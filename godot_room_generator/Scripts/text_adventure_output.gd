class_name TextAdventure
extends Node2D

@onready var roomGenerator = $"../RoomGenerator"
@onready var myText = $TextAdventureOutput 

var textAdventureStarted = false

# Called when the node enters the scene tree for the first time.
func StartTextAdventure():
	myText.text = "Welcome to the Dungeon!\n\n"
	PrintRoom()
	textAdventureStarted = true
	
func LeaveTextAdventure():
	textAdventureStarted = false
	
func PrintRoom():
	myText.text += "You are in the [color=green]" + roomGenerator.currentRoom.roomName + "[/color].\n\n"
	
	if(roomGenerator.currentRoom.CanGoNorth()):
		var nextRoom = roomGenerator.currentRoom.GetRoomNorth()
		myText.text += "Press [color=green](1)[/color] to go [color=green]North[/color] to the [color=green]" + nextRoom.roomName + "[/color].\n"
	
	if(roomGenerator.currentRoom.CanGoSouth()):
		var nextRoom = roomGenerator.currentRoom.GetRoomSouth()
		myText.text += "Press [color=green](2)[/color] to go [color=green]South[/color] to the [color=green]" + nextRoom.roomName + "[/color].\n"
	
	if(roomGenerator.currentRoom.CanGoWest()):
		var nextRoom = roomGenerator.currentRoom.GetRoomWest()
		myText.text += "Press [color=green](3)[/color] to go [color=green]West[/color] to the [color=green]" + nextRoom.roomName + "[/color].\n"
	
	if(roomGenerator.currentRoom.CanGoEast()):
		var nextRoom = roomGenerator.currentRoom.GetRoomEast()
		myText.text += "Press [color=green](4)[/color] to go [color=green]East[/color] to the [color=green]" + nextRoom.roomName + "[/color].\n"
		
func _input(event):
	if(not textAdventureStarted):
		return 
		
	if event.is_action_pressed("North"):
		if(roomGenerator.currentRoom.CanGoNorth()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomNorth() 
			myText.text += "\nGoing North ... \n\n"
			PrintRoom()
		else:
			myText.text += "\nCan not go North ... \n"
	elif event.is_action_pressed("South"):
		if(roomGenerator.currentRoom.CanGoSouth()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomSouth() 
			myText.text += "\nGoing South ... \n\n"
			PrintRoom()
		else:
			myText.text += "\nCan not go South ... \n"
	elif event.is_action_pressed("West"):
		if(roomGenerator.currentRoom.CanGoWest()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomWest() 
			myText.text += "\nGoing West ... \n\n"
			PrintRoom()
		else:
			myText.text += "\nCan not go West ... \n"		
	elif event.is_action_pressed("East"):
		if(roomGenerator.currentRoom.CanGoEast()):
			roomGenerator.currentRoom = roomGenerator.currentRoom.GetRoomEast() 
			myText.text += "\nGoing East ... \n\n"
			PrintRoom()
		else:
			myText.text += "\nCan not go East ... \n"	

			
