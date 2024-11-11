class_name Player3D
extends RigidBody3D

var dungeon3DStarted = false
var moveDirection = Vector3.ZERO
var moveSpeed = 5
var roomData : RoomNode

@onready var generator = $"../../RoomGenerator" 
@onready var roomText =  $"../DungeonRoom/Label3D"
@onready var northEntrance = $"../DungeonRoom/North"
@onready var southEntrance = $"../DungeonRoom/South"
@onready var eastEntrance = $"../DungeonRoom/East"
@onready var westEntrance = $"../DungeonRoom/West"
 
func StartDungeon3D():  
	dungeon3DStarted = true 
	UpdateRoom()
	
func LeaveDungeon3D(): 
	dungeon3DStarted = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body. 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.move_toward(position + moveDirection, delta * moveSpeed)
	
	if(northEntrance.visible && position.distance_to(northEntrance.position) < 1.4):
		GoNorth()
		position = Vector3(0,1.5,5)
	elif(southEntrance.visible && position.distance_to(southEntrance.position) < 1.4):
		GoSouth()
		position = Vector3(0,1.5,-5)
	elif(eastEntrance.visible && position.distance_to(eastEntrance.position) < 1.4):
		GoEast()
		position = Vector3(-5,1.5,0)
	elif(westEntrance.visible && position.distance_to(westEntrance.position) < 1.4):
		GoWest()
		position = Vector3(5,1.5,0)
	elif(position.x > 7.5):
		position.x = 7.5
	elif(position.x < -7.5):
		position.x = -7.5	
	elif(position.z > 7.5):
		position.z = 7.5	
	elif(position.z < -7.5):
		position.z = -7.5	 
	 
func _input(event):
	if(not dungeon3DStarted):
		return    
	if event.is_action_pressed("North"):
		moveDirection = Vector3.FORWARD
	elif event.is_action_pressed("South"):
		moveDirection = Vector3.BACK
	elif event.is_action_pressed("West"):
		moveDirection = Vector3.LEFT
	elif event.is_action_pressed("East"):
		moveDirection = Vector3.RIGHT
	else:
		moveDirection = Vector3.ZERO
 
func GoWest():
	print("WEST")
	if(generator.currentRoom.CanGoWest()):
			generator.currentRoom = generator.currentRoom.GetRoomWest()  
			UpdateRoom()
 
func GoNorth():
	print("NORTH") 
	if(generator.currentRoom.CanGoNorth()):
			generator.currentRoom = generator.currentRoom.GetRoomNorth() 
			UpdateRoom()

func GoSouth():
	print("SOUTH")
	if(generator.currentRoom.CanGoSouth()):
			generator.currentRoom = generator.currentRoom.GetRoomSouth() 
			UpdateRoom()
 
func GoEast():
	print("EAST") 
	if(generator.currentRoom.CanGoEast()):
			generator.currentRoom = generator.currentRoom.GetRoomEast()  
			UpdateRoom()
 	
	
func UpdateRoom(): 
	
		roomData = generator.currentRoom
		roomText.text = roomData.roomName;
		northEntrance.visible = roomData.CanGoNorth()
		southEntrance.visible = roomData.CanGoSouth()
		westEntrance.visible = roomData.CanGoWest()
		eastEntrance.visible = roomData.CanGoEast()
		  
