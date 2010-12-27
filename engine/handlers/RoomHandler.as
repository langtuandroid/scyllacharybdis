package handlers 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.RoomSettings;
	import com.smartfoxserver.v2.requests.RoomExtension;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;
	import models.CreateRoomModel;

	import core.objects.NetworkObject;
	import core.objects.BaseObject;	
	import core.managers.EventManager;
	import models.RoomModel;

	/**
	*/
	[ComponentType = RoomHandler]
	[Requires (EventManager)]
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

		private var _eventManager:EventManager;
		private var _currentRoom:String;
		private var _previousRoom:String;
		private var _gameRoom:Boolean = false;

		/**
		 * Awake is called at the construction of the object
		 * Register all the listeners
		 * @private
		 */
		public final override function engine_awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
			
			owner.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			owner.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
			owner.sfs.addEventListener(SFSEvent.ROOM_ADD, onRoomAdd);
			owner.sfs.addEventListener(SFSEvent.ROOM_REMOVE, onRoomRemove);
			owner.sfs.addEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			owner.sfs.addEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);
			owner.sfs.addEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);
			
			
			super.engine_start();
			
			_eventManager.registerListener("NETWORK_CREATEROOM", this, requestCreateRoom );
			_eventManager.registerListener("NETWORK_JOINROOM", this, requestJoinRoom );
			_eventManager.registerListener("NETWORK_LEAVBROOM", this, requestLeaveRoom );
		}
		
		/**
		 * Engine start should handle engine related start. 
		 * @private
		 */
		public final override function engine_start():void 
		{
			super.engine_start();
		}
		
		/**
		 * Engine stop should handle engine related stop. 
		 * @private
		 */
		public final override function engine_stop():void 
		{
			super.engine_stop();
		}
		
		/**
 		 * Destroy is called at the removal of the object
		 * Unregister listeners
		 * @private
		 */
		public final override function engine_destroy():void
		{
			_eventManager.unregisterListener("NETWORK_CREATEROOM", this, requestCreateRoom );
			_eventManager.unregisterListener("NETWORK_JOINROOM", this, requestJoinRoom );
			_eventManager.unregisterListener("NETWORK_LEAVBROOM", this, requestLeaveRoom );
			
			super.engine_destroy();

			owner.sfs.removeEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			owner.sfs.removeEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			owner.sfs.removeEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);

			owner.sfs.removeEventListener(SFSEvent.ROOM_ADD, onRoomAdd);
			owner.sfs.removeEventListener(SFSEvent.ROOM_REMOVE, onRoomRemove);
			owner.sfs.removeEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			owner.sfs.removeEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);
			owner.sfs.removeEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);
		}

		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
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
		public function requestCreateRoom( room:CreateRoomModel ):void
		{
			createRoom( room.name, room.roomPass, room.maxSize, room.extensionId, room.extensionClass );
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
		private function joinRoom(name:String):void
		{
			_gameRoom = false;
			if ( _previousRoom == null ) 
			{
				_currentRoom = name;
			}
			_previousRoom = _currentRoom;
			_currentRoom = name;

			_currentRoom = name;
			var request:JoinRoomRequest = new JoinRoomRequest(name);
			trace("sending join room request: " + name );
			owner.sfs.send(request);
		}		
		
		/**
		 * Create a room
		 * 
		 * @param	roomName (String) Room name
		 * @param	roomPwd (String Room password
		 * @param	roomMaxS (int) Room Max size 
		 * @param	extensionId (String) The module name. Example: sfsTris
		 * @param	extensionClass (String) The fully qualified class. Example: sfs2x.extensions.games.tris.SFSTrisGame
		 */
		private function createRoom(roomName:String, roomPwd:String=null, roomMaxS:int=0, extensionId:String="", extensionClass:String = ""):void
		{
			_gameRoom = true;
			if (roomName.length > 0)
			{
				var settings:RoomSettings = new RoomSettings(roomName)
				settings.groupId = "game"
				settings.password = roomPwd
				settings.isGame = true
				settings.maxUsers = roomMaxS
				settings.maxSpectators = 0
				if ( extensionId != "" && extensionClass != null ) 
				{
					settings.extension = new RoomExtension(extensionId, extensionClass)
				}
				
				owner.sfs.send( new CreateRoomRequest(settings, true) )
			}
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom():void
		{
			var request:JoinRoomRequest = new JoinRoomRequest(_previousRoom);
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
			if ( ! _gameRoom ) 
			{
				_eventManager.fireEvent("JOINROOM_SUCCESS", evt);
			} 
			else 
			{
				_eventManager.fireEvent("CREATEROOM_SUCCESS", evt);
				
			}
		}		
		
		/**
		 * On user count change, update the rooms list.
		 */
		private function onUserCountChange(evt:SFSEvent):void
		{
			_eventManager.fireEvent("USERCOUNT_CHANGED", evt );
		}

		/**
		 * On user entering the current room, show his/her name in the users list.
		 */
		private function onUserEnterRoom(evt:SFSEvent):void
		{
			var user:User = evt.params.user;
			_eventManager.fireEvent("USER_ENTER_ROOM", evt );
		}

		/**
		 * On user leaving the current room, remove his/her name from the users list.
		 */
		private function onUserExitRoom(evt:SFSEvent):void
		{
			var user:User = evt.params.user;
			_eventManager.fireEvent("USER_EXIT_ROOM", evt );
		}

		/**
		 * On room added, show it in the rooms list.
		 */
		private function onRoomAdd(evt:SFSEvent):void
		{
			var room:Room = evt.params.room;
			_eventManager.fireEvent("ROOM_ADD", evt );
		}

		/**
		 * On room removed, remove it from the rooms list.
		 */
		private function onRoomRemove(evt:SFSEvent):void
		{
			var room:Room = evt.params.room;
			_eventManager.fireEvent("ROOM_REMOVE", evt );
		}		
		
	}
}