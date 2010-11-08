package engine.core 
{
	import flash.utils.getQualifiedClassName;
	
	class NetworkManager {
		
		/***********************************/
		// Singleton boilerplate
		/***********************************/
		public function NetworkManager( se:SingletonEnforcer ) 
		{
		}
		
		private static var _sInstance:NetworkManager = null;
		public static function get instance():NetworkManager 
		{
			if (_sInstance == null) 
			{
				_sInstance = new NetworkManager( new SingletonEnforcer() );
				_sInstance.awake();
			}
			
			return _sInstance;
		}		
		/***********************************/
		
		private var _sfs:SmartFox = new SmartFox(true);
		private var _connectionHandler = null;
		private var _roomHandler = null;
		
		private const THE_LOBBY_NAME:String = "The Lobby";
		
		/**
		 * Get the smartfox server
		 */
		public function get sfs():SmartFox { return _sfs; }
		
		/**
		 * Get the connection handler
		 */
		public function get connectionHandler():void { return _connectionHandler; }
		
		/**
		 * Set the connection handler
		 */
		public function set connectionHandler( handler:ConnectionHandler ):void
		{
			if ( _connectionHandler != null ) {
				MemoryManager.instance.destroy(_connectionHandler);
			}
			_connectionHandler = handler;
		}

		/**
		 * Get the room handler
		 */
		public function get roomHandler():void { return _roomHandler; }
		/**
		 * Set the room handler
		 */
		public function set roomHandler( handler:RoomHandler ):void
		{
			if ( _roomHandler != null ) {
				MemoryManager.instance.destroy(_roomHandler);
			}
			_roomHandler = handler;
		}
		
		/** 
		 * Connect to the server
		 */
		public function connect():void
		{
			if ( _connectionHandler != null ) 
			{
				_connectionHandler.connect();
			}
		}
		
		/**
		 * Disconnect from the server
		 */
		private function disconnect():void
		{
			_connectionHandler.disconnect();
		}		
		
		
		/**
		 * Login to the server
		 * @param	userName (String) Users name
		 * @param	password (String) Users password
		 */
		public function login(userName:String, password:String):void
		{
			_loginHandler.login(userName, password);
		}

		/**
		* Join the passed room.
		*/
		private function joinRoom():void
		{
			var request:JoinRoomRequest = new JoinRoomRequest(THE_LOBBY_NAME);
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
		private function leaveGameRoom():void
		{
			var request:JoinRoomRequest = new JoinRoomRequest(THE_LOBBY_NAME);
			sfs.send(request);
		}		

		public function backToLoginScreen():void {}		
				
		/**
		 * Helper function for displaying errors
		 * @param	msg (String) The error message
		 */
		protected function dTrace(msg:String):void
		{
			trace ( "--> " + msg + "\n" );
			
			// Create view to print stuff too
			//ta_debug.text += "--> " + msg + "\n";
		}		
	}
}

final class SingletonEnforcer { }