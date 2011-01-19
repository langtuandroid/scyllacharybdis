package com.scyllacharybdis.networking.handlers 
{
	import com.scyllacharybdis.constants.NetworkEvents;
	import com.scyllacharybdis.interfaces.IBaseObject;
	import com.scyllacharybdis.networking.models.CreateRoomModel;
	import com.scyllacharybdis.networking.models.RoomModel;
	import com.scyllacharybdis.networking.NetworkEventHandler;
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.RoomSettings;
	import com.smartfoxserver.v2.requests.RoomExtension;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.User;

	/**
	*/
	[Singleton]
	public class RoomHandler implements IBaseObject
	{
		private var _networkEventHandler:NetworkEventHandler;
		
		private var _currentRoom:String;
		private var _previousRoom:String;
		private var _gameRoom:Boolean = false;

		/**
		 * Awake is called at the construction of the object
		 * Register all the listeners
		 * @private
		 */
		public function RoomHandler(networkEventHandler:NetworkEventHandler):void
		{
			// Get the event manager
			_networkEventHandler = networkEventHandler;
			
			_networkEventHandler.addEventListener(SFSEvent.ROOM_CREATION_ERROR, this, onRoomCreationError);
			_networkEventHandler.addEventListener(SFSEvent.ROOM_JOIN, this, onJoinRoom);
			_networkEventHandler.addEventListener(SFSEvent.ROOM_JOIN_ERROR, this, onJoinRoomError);
			_networkEventHandler.addEventListener(SFSEvent.ROOM_ADD, this, onRoomAdd);
			_networkEventHandler.addEventListener(SFSEvent.ROOM_REMOVE, this, onRoomRemove);
			_networkEventHandler.addEventListener(SFSEvent.USER_ENTER_ROOM, this, onUserEnterRoom);
			_networkEventHandler.addEventListener(SFSEvent.USER_EXIT_ROOM, this, onUserExitRoom);
			_networkEventHandler.addEventListener(SFSEvent.USER_COUNT_CHANGE, this, onUserCountChange);
			
			super.engine_start();
			
			_networkEventHandler.addEventListener(NetworkEvents.CREATEROOM, this, requestCreateRoom );
			_networkEventHandler.addEventListener(NetworkEvents.JOINROOM, this, requestJoinRoom );
			_networkEventHandler.addEventListener(NetworkEvents.LEAVBROOM, this, requestLeaveRoom );
		}
		
		
		/**
 		 * Destroy is called at the removal of the object
		 * Unregister listeners
		 * @private
		 */
		public function destroy():void
		{
			_networkEventHandler.removeEventListener(NetworkEvents.CREATEROOM, this, requestCreateRoom );
			_networkEventHandler.removeEventListener(NetworkEvents.JOINROOM, this, requestJoinRoom );
			_networkEventHandler.removeEventListener(NetworkEvents.LEAVBROOM, this, requestLeaveRoom );
			
			super.engine_destroy();

			_networkEventHandler.removeEventListener(SFSEvent.ROOM_CREATION_ERROR, this, onRoomCreationError);
			_networkEventHandler.removeEventListener(SFSEvent.ROOM_JOIN, this, onJoinRoom);
			_networkEventHandler.removeEventListener(SFSEvent.ROOM_JOIN_ERROR, this, onJoinRoomError);

			_networkEventHandler.removeEventListener(SFSEvent.ROOM_ADD, this, onRoomAdd);
			_networkEventHandler.removeEventListener(SFSEvent.ROOM_REMOVE, this, onRoomRemove);
			_networkEventHandler.removeEventListener(SFSEvent.USER_ENTER_ROOM, this, onUserEnterRoom);
			_networkEventHandler.removeEventListener(SFSEvent.USER_EXIT_ROOM, this, onUserExitRoom);
			_networkEventHandler.removeEventListener(SFSEvent.USER_COUNT_CHANGE, this, onUserCountChange);
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

			_networkEventHandler.sendServerMessage(new JoinRoomRequest(name));
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
				
				_networkEventHandler.sendServerMessage( new CreateRoomRequest(settings, true) )
			}
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom():void
		{
			_networkEventHandler.sendServerMessage(new JoinRoomRequest(_previousRoom));
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
			_networkEventHandler.fireEvent(NetworkEvents.JOINROOM_FAILED, evt.params.errorMessage);
		}

		/**
		 * onJoinRoom event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoom(evt:SFSEvent):void
		{
			if ( ! _gameRoom ) 
			{
				_networkEventHandler.fireEvent(NetworkEvents.JOINROOM_SUCCESS, evt);
			} 
			else 
			{
				_networkEventHandler.fireEvent(NetworkEvents.CREATEROOM_SUCCESS, evt);
			}
		}		
		
		/**
		 * On user count change, update the rooms list.
		 */
		private function onUserCountChange(evt:SFSEvent):void
		{
			_networkEventHandler.fireEvent(NetworkEvents.USERCOUNT_CHANGED, evt );
		}

		/**
		 * On user entering the current room, show his/her name in the users list.
		 */
		private function onUserEnterRoom(evt:SFSEvent):void
		{
			var user:User = evt.params.user;
			_networkEventHandler.fireEvent(NetworkEvents.USER_ENTER_ROOM, evt );
		}

		/**
		 * On user leaving the current room, remove his/her name from the users list.
		 */
		private function onUserExitRoom(evt:SFSEvent):void
		{
			var user:User = evt.params.user;
			_networkEventHandler.fireEvent(NetworkEvents.USER_EXIT_ROOM, evt );
		}

		/**
		 * On room added, show it in the rooms list.
		 */
		private function onRoomAdd(evt:SFSEvent):void
		{
			var room:Room = evt.params.room;
			_networkEventHandler.fireEvent(NetworkEvents.ROOM_ADD, evt );
		}

		/**
		 * On room removed, remove it from the rooms list.
		 */
		private function onRoomRemove(evt:SFSEvent):void
		{
			var room:Room = evt.params.room;
			_networkEventHandler.fireEvent(NetworkEvents.ROOM_REMOVE, evt );
		}		
		
	}
}