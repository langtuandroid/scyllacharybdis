package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.RoomSettings;
	import com.smartfoxserver.v2.requests.RoomExtension;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.entities.Room;

	import core.NetworkObject;
	import core.BaseObject;	
	import core.EventManager;
	import models.GameRoomModel;
	import models.RoomModel;

	/**
	*/
	public class RoomHandler extends BaseObject
	{
		/****************************************/
		// Type definition
		/****************************************/
		
		public override function getType():String 
		{
			return ROOM_HANDLER;
		}
		
		/****************************************/
		// Class Details
		/****************************************/

		private var _roomName:String = "The Lobby";
		private var _eventManager:EventManager;

		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public final override function engine_awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
			
			owner.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
			
			super.engine_start();
			
			_eventManager.registerListener("NETWORK_JOINROOM", this, requestJoinRoom );
			_eventManager.registerListener("NETWORK_JOINGAMEROOM", this, requestJoinGameRoom );
			_eventManager.registerListener("NETWORK_LEAVBROOM", this, requestLeaveRoom );
		}
		
		/**
		 * Engine start should handle engine related start. 
		 */
		public final override function engine_start():void 
		{
			super.engine_start();
		}
		
		/**
		 * Engine stop should handle engine related stop. 
		 */
		public final override function engine_stop():void 
		{
			super.engine_stop();
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public final override function engine_destroy():void
		{
			_eventManager.unregisterListener("NETWORK_JOINROOM", this, requestJoinRoom );
			_eventManager.unregisterListener("NETWORK_JOINGAMEROOM", this, requestJoinGameRoom );
			_eventManager.unregisterListener("NETWORK_LEAVBROOM", this, requestLeaveRoom );
			
			super.engine_destroy();

			owner.sfs.removeEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			owner.sfs.removeEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			owner.sfs.removeEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
		}
		
		/**
		 * Request Join Room handler
		 * @param	room
		 */
		public function requestJoinRoom( room:RoomModel ):void
		{
			joinRoom( room.name );
		}

		/**
		 * Request Join Game Room handler
		 * @param	room
		 */
		public function requestJoinGameRoom( room:GameRoomModel ):void
		{
			createGameRoom( room.name, room.roomPass, room.maxSize, room.extensionId, room.extensionClass );
		}
		
		/** 
		 * Leave the game room
		 */
		public function requestLeaveRoom():void
		{
			leaveGameRoom();
		}
		
		/**
		* Join the passed room.
		*/
		private function joinRoom(name:String = ""):void
		{
			if ( name == "" ) 
			{
				name = _roomName;
			} 
			_roomName = name;
			var request:JoinRoomRequest = new JoinRoomRequest(name);
			trace("sending join room request: " + name );
			owner.sfs.send(request);
		}		
		
		/**
		 * Create a game room
		 * 
		 * @param	roomName (String) Room name
		 * @param	roomPwd (String Room password
		 * @param	roomMaxS (int) Room Max size 
		 * @param	extensionId (String) The module name
		 * @param	extensionClass (String) The fully qualified class
		 */
		private function createGameRoom(roomName:String, roomPwd:String=null, roomMaxS:int=0, extensionId:String="sfsChess", extensionClass:String = "sfs2x.extensions.games.tris.SFSTrisGame"):void
		{
			if (roomName.length > 0)
			{
				var settings:RoomSettings = new RoomSettings(roomName)
				settings.groupId = "game"
				settings.password = roomPwd
				settings.isGame = true
				settings.maxUsers = 2
				settings.maxSpectators = roomMaxS
				settings.extension = new RoomExtension(extensionId, extensionClass)
				
				owner.ssfs.send( new CreateRoomRequest(settings, true, owner.sfs.lastJoinedRoom) )
			}		
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom():void
		{
			var request:JoinRoomRequest = new JoinRoomRequest(_roomName);
			owner.sfs.send(request);
		}		

	
		/**
		 * onRoomCreationError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onRoomCreationError(evt:SFSEvent):void
		{
			trace("===> " + evt.params.errorMessage);
			trace("Room creation error:\n" + evt.params.error);
		}

		/**
		 * onJoinRoomError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoomError(evt:SFSEvent):void
		{
			_eventManager.fireEvent("JOINROOM_FAILED", evt.params.errorMessage);
		}

		/**
		 * onJoinRoom event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoom(evt:SFSEvent):void
		{
			_eventManager.fireEvent("JOINROOM_SUCESS", evt);
		}		
	}
}