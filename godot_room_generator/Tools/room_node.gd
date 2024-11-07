class_name RoomNode
extends Node

var connectedRooms = [RoomNode]
var roomCoordinates : Vector2i
var roomEmpty : bool = true
var roomName : String = "Empty Spot"
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func updateRoom(_previousRoom : RoomNode,  _coordinates):
	connectRoom(_previousRoom)
	roomCoordinates = _coordinates 
	roomEmpty = false
	
func setupRoom(_previousRoom : RoomNode,  _coordinates : Vector2i, _roomName : String):
	updateRoom(_previousRoom,_coordinates)
	roomName = _roomName
	
	
func connectRoom(_roomToConnect : RoomNode):
	if(_roomToConnect != null && not (_roomToConnect in connectedRooms) ):
		connectedRooms.append(_roomToConnect)
		_roomToConnect.connectedRooms.append(self) 
