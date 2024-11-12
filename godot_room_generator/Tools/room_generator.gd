class_name RoomGen
extends Node 

var grid_width = 10
var grid_height = 10
var gridArray = []
var rng = RandomNumberGenerator.new()
var grid_initialized = false
var debugLog : String = ""
var walkerPosition = Vector2i.ZERO 
var startRoom = null
var currentRoom = null


@onready var roomCollection = $"../RoomCollection"
@onready var generatorUI = $"../GenerationUI"
@onready var textAdventure = $"../TextAdventure" 
@onready var dungeonMap2D =  $"../2D_DungeonMap"
@onready var dungeon3D =   $"../3D_Dungeon"
@onready var dungeonPlayer =  $"../3D_Dungeon/Player"
@onready var dungeonButton =  $"../Dungeon3D_UI/ReturnToGeneratorButton"
  
# Called when the node enters the scene tree for the first time.
func _ready():
	CalculateRooms() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func CalculateRooms():
		CreateGrid()
		DrunkWalk(0.1)
		
func DrunkWalk(displayDelay : float): 
	var max_iterations = 30
	var itr = 0
	var lastRoom : RoomNode = null 
	
	#get random position in the grid array
	walkerPosition.x = randi()%(grid_width-1)
	walkerPosition.y = randi()%(grid_height-1)  
	
	debugLog += "Drunk Walk starts at position - " + str(walkerPosition.x) + ", " + str(walkerPosition.y);
	
	var gridRoom = gridArray[walkerPosition.y][walkerPosition.x]
	gridRoom.setupRoom(lastRoom,walkerPosition,roomCollection.GetStartRoomName())
										 
	debugLog += " - generated [color=green]" + gridRoom.roomName + "[/color]\n"
	
	lastRoom = gridRoom  
	startRoom = gridRoom
	currentRoom = gridRoom
	  
	await get_tree().create_timer(displayDelay).timeout
			
	while itr < max_iterations:
			
			# Perform random walk
			# 1- choose random direction
			# 2- check that direction is in bounds
			# 3- move in that direction
			var random_direction = GetRandomDirection() 
			 
			if (walkerPosition.x + random_direction.x >= 0 and 
				walkerPosition.x + random_direction.x < grid_width and
				walkerPosition.y + random_direction.y >= 0 and
				walkerPosition.y + random_direction.y < grid_height):
					
					await get_tree().create_timer(displayDelay).timeout
					
					debugLog += "Drunk Walk into direction - [color=green]" + GetDirectionName(random_direction) + "[/color]" ;
					 
					walkerPosition += random_direction 
					gridRoom = gridArray[walkerPosition.y][walkerPosition.x]
					
					if(gridRoom.roomEmpty): 
						gridRoom.setupRoom(lastRoom,walkerPosition,roomCollection.GetRandomRoomName())
						debugLog += " - [color=green]" + gridRoom.roomName + "[/color] generated at - [color=green]" + str(walkerPosition.x) + ", " + str(walkerPosition.y) + "[/color]\n";
						
					else:
						debugLog += " - Returned to [color=green]" + gridRoom.roomName + "[/color]\n";
						gridRoom.updateRoom(lastRoom,walkerPosition) 
					 
					lastRoom = gridRoom
					itr += 1
					
					

func GetRandomDirection():
	var directions = [[-1, 0], [1, 0], [0, 1], [0, -1]]
	var direction = directions[rng.randi()%4]
	return Vector2i(direction[0], direction[1])
	
	
func GetDirectionName(direction : Vector2i): 
	if(direction == Vector2i.UP):
		return "North"
	elif(direction == Vector2i.DOWN):
		return "South"
	elif(direction == Vector2i.LEFT):
		return "West"
	elif(direction == Vector2i.RIGHT):
		return "East" 
	return "ERROR_WRONG_DIRECTION_VECTOR"
	
	
#initialized the Grid Array
func CreateGrid():    
	gridArray = [] 
	
	for x in range(grid_width):
		
		gridArray.append([]) 
		gridArray[x] = []
		for y in range(grid_height):
			#for each collum in the grid add another empty array to the grid array
			gridArray[x].append([])
			var newRoom = RoomNode.new()
			#create a new room data node and append it to the X Y position in the array
			gridArray[x][y] = newRoom  
			
	grid_initialized = true 
			
func GetDebugData():
	var debugText : String = "";  
	var numIndex : int = 0;
	var rowIndex : int = 0;
	
	if grid_initialized:
		for row in gridArray: 
			numIndex = 0 
			for num : RoomNode in row:
				if(num.roomEmpty):
					debugText += "[color=black]⮽⮀[/color]"
				else:
					if(num.roomCoordinates == walkerPosition):
						debugText += "[color=green]⮽[/color]"
					else:
						debugText += "[color=white]⮽[/color]"
					
					var testDebug : String = str(num.roomCoordinates.x) + "," + str(num.roomCoordinates.y)
					
					if(num.roomCoordinates.x < grid_width-1 && num.connectedRooms.has(row[numIndex+1])):
						debugText += "[color=white]⮀[/color]"
					else:
						debugText += "[color=black]⮀[/color]" 
				numIndex += 1
			debugText += "\n" 
			
			numIndex = 0 
			for num : RoomNode in row:
				if(num.roomEmpty):
					debugText += "[color=black]⮃⮀[/color]"
				else: 
					var testDebug : String = str(num.roomCoordinates.x) + "," + str(num.roomCoordinates.y)
					if(num.roomCoordinates.y < grid_height-1 && num.connectedRooms.has(gridArray[rowIndex+1][numIndex])):
						debugText += "[color=white]⮃[/color][color=black]⮀[/color]"
					else:
						debugText += "[color=black]⮃⮀[/color]" 
				numIndex += 1
			debugText += "\n"  
			rowIndex += 1
			
	return debugText
	
func Restart():  
	roomCollection.ResetRoomNames()
	grid_initialized = false
	debugLog = ""
	CreateGrid()
	DrunkWalk(1)
	
func StartTextAdventure():
	generatorUI.visible = false
	textAdventure.visible = true
	textAdventure.StartTextAdventure()
	
func Start2DMap():
	generatorUI.visible = false
	dungeonMap2D.visible = true
	dungeonMap2D.StartDungeonMap()

	
func Start3DDungeon():
	generatorUI.visible = false
	dungeon3D.visible = true
	dungeonButton.visible = true 
	dungeonPlayer.StartDungeon3D()	
	 
	
func BackToGenerator():
	generatorUI.visible = true 
	textAdventure.visible = false 
	textAdventure.LeaveTextAdventure() 
	dungeonMap2D.visible = false
	dungeonMap2D.LeaveDungeonMap()
	dungeon3D.visible = false
	dungeonButton.visible = false
	dungeonPlayer.LeaveDungeon3D()
