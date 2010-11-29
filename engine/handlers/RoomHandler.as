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

		private var _eventManager:EventManager;
		private var _currentRoom:String;
		private var _previousRoom:String;
		private var _gameRoom:Boolean = false;

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
			owner.sfs.addEventListener(SFSEvent.ROOM_ADD, onRoomAdd);
			owner.sfs.addEventListener(SFSEvent.ROOM_REMOVE, onRoomRemove);
			owner.sfs.addEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			owner.sfs.addEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);
			owner.sfs.addEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);
			
			
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

			owner.sfs.removeEventListener(SFSEvent.ROOM_ADD, onRoomAdd);
			owner.sfs.removeEventListener(SFSEvent.ROOM_REMOVE, onRoomRemove);
			owner.sfs.removeEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			owner.sfs.removeEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);
			owner.sfs.removeEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);
			
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
			_gameRoom = true;
			if (roomName.length > 0)
			{
				var settings:RoomSettings = new RoomSettings(roomName)
				settings.groupId = "game"
				settings.password = roomPwd
				settings.isGame = true
				settings.maxUsers = 2
				settings.maxSpectators = roomMaxS
				settings.extension = new RoomExtension(extensionId, extensionClass)
				
				owner.sfs.send( new CreateRoomRequest(settings, true, owner.sfs.lastJoinedRoom) )
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
				_eventManager.fireEvent("JOINGAMEROOM_SUCCESS", evt);
				
			}
		}		
		
		/**
		 * On user count change, update the rooms list.
		 */
		private function onUserCountChange(evt:SFSEvent):void
		{
			_eventManager.fireEvent("USERCOUNT_CHANGED", evt );
			//ls_rooms.dataProvider.refresh();
		}

		/**
		 * On user entering the current room, show his/her name in the users list.
		 */
		private function onUserEnterRoom(evt:SFSEvent):void
		{
			var user:User = evt.params.user;
			_eventManager.fireEvent("USER_ENTER_ROOM", evt );
			
			// Add user to list
			//var dataProvider:ArrayCollection = ls_users.dataProvider as ArrayCollection;
			//dataProvider.addItem(user);
			
			// Show system message ( will be switched to an event )
			//showChatMessage("User " + user.name + " entered the room", null);
		}

		/**
		 * On user leaving the current room, remove his/her name from the users list.
		 */
		private function onUserExitRoom(evt:SFSEvent):void
		{
			var user:User = evt.params.user;
			_eventManager.fireEvent("USER_EXIT_ROOM", evt );
			
			// We are not interested in the user's own exit event, because that would cause his/her username to be removed from the users list
			// In fact whenever a room is joined, the previous one is left, so we halway receive this event
			if (!user.isItMe)
			{
				// Remove user from list
				//var dataProvider:ArrayCollection = ls_users.dataProvider as ArrayCollection;
				//dataProvider.removeItemAt(dataProvider.getItemIndex(user));
				//dataProvider.refresh();
				
				// Show system message
				//showChatMessage("User " + user.name + " left the room", null);
			}
		}

		/**
		 * On room added, show it in the rooms list.
		 */
		private function onRoomAdd(evt:SFSEvent):void
		{
			var room:Room = evt.params.room;
			_eventManager.fireEvent("ROOM_ADD", evt );
			
			//var dataProvider:ArrayCollection = ls_rooms.dataProvider as ArrayCollection;
			//dataProvider.addItem(room);
		}

		/**
		 * On room removed, remove it from the rooms list.
		 */
		private function onRoomRemove(evt:SFSEvent):void
		{
			var room:Room = evt.params.room;
			_eventManager.fireEvent("ROOM_REMOVE", evt );
			
			//var dataProvider:ArrayCollection = ls_rooms.dataProvider as ArrayCollection;
			
			//for each (var r:Room in dataProvider)
			//{
				//if (r.id == room.id)
				//{
					//dataProvider.removeItemAt(dataProvider.getItemIndex(r));
					//break;
				//}
			//}
		}		
		
	}
}