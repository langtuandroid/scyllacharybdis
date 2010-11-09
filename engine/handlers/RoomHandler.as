package engine.handlers 
{
	/**
	 */
	public class RoomHandler extends Handler
	{
		
		/****************************************/
		// Dependency Injection calls
		/****************************************/
		
		/** 
		 * Return the type of object
		 */
		public static function get type():String { return BASE_OBJECT; }
		
		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( getQualifiedClassName(this), true );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{  
			return Dependencies(NetworkManager);
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		private var _networkManager;
		public function set dependencies( dep:Dictionary ):void 
		{ 
			_networkManager = dep[NetowrkManager];
		}
		
		/****************************************/
		// Overide function
		/****************************************/
		
		/**
		* Awake is called at the construction of the object
		* Register all the listeners
		*/
		public override function awake():void
		{
			NetworkManager.sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			NetworkManager.sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			NetworkManager.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
		}
		
		/**
		* Destroy is called at the removal of the object
		* Unregister listeners
		*/
		public override function destroy():void
		{
			NetworkManager.sfs.removeEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			NetworkManager.sfs.removeEventListener(SFSEvent.ROOM_JOIN, onJoinRoom);
			NetworkManager.sfs.removeEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinRoomError);
		}
		
		/****************************************/
		// Class specific
		/****************************************/
		
		private var _roomName:String;
		
		/**
		* Join the passed room.
		*/
		private function joinRoom(name:String):void
		{
			_roomName = name;
			var request:JoinRoomRequest = new JoinRoomRequest(name);
			sfs.send(request);
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
		public function createGameRoom(roomName:String, roomPwd:String=null, roomMaxS:int=0, extensionId:String="sfsChess", extensionClass:String = "sfs2x.extensions.games.tris.SFSTrisGame"):void
		{
			if (roomName.length > 0)
			{
				var settings:RoomSettings = new RoomSettings(roomName)
				settings.groupId = "game"
				settings.password = roomPwd
				settings.isGame = true
				settings.maxUsers = 2
				settings.maxSpectators = roomMaxS
				settings.extension = new RoomExtension(EXTENSION_ID, EXTENSIONS_CLASS)
				
				sfs.send( new CreateRoomRequest(settings, true, sfs.lastJoinedRoom) )
			}		
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom(name:String = ""):void
		{
			if ( name == null ) {
				name = _roomName;
			}
			
			var request:JoinRoomRequest = new JoinRoomRequest(THE_LOBBY_NAME);
			sfs.send(request);
		}		

		
		
		/****************************************/
		// Event Handlers
		/****************************************/
		
		/**
		 * onRoomCreationError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onRoomCreationError(evt:SFSEvent):void
		{
			NetworkManager.sfs.dTrace("===> " + evt.params.errorMessage);
			NetworkManager.sfs.dTrace("Room creation error:\n" + evt.params.error);
		}

		/**
		 * onJoinRoomError event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoomError(evt:SFSEvent):void
		{
			NetworkManager.sfs.dTrace("Room join error:\n" + evt.params.errorMessage);
		}

		/**
		 * onJoinRoom event handler
		 * @param	evt (SFSEvent)
		 */
		protected function onJoinRoom(evt:SFSEvent):void
		{
			var room:Room = evt.params.room
			
			if (room.isGame)
			{
				// viewstack.selectedChild = view_game
				
				//if (gameViewInited) 
				// {
				//	initGame()
				// }
			}
		}		
	}
}