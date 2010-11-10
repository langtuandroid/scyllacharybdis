package core 
{
	import com.smartfoxserver.v2.SmartFox;
	
	import flash.utils.Dictionary;
	import core.BaseObject;
	import di.Dependencies;
	import di.Description;
	import handlers.*;

	class NetworkManager extends BaseObject
	{
		/****************************************/
		// Dependency Injection calls
		/****************************************/

		/**
		 * Return the class description
		 */
		public static function get description():Description  
		{ 
			return new Description( NetworkManager, Description.SINGLETON_OBJECT );
		}

		/**
		 * Return the class dependencies
		 */
		public static function get dependencies():Dependencies  
		{  
			return new Dependencies(ConnectionHandler, LoginHandler, RoomHandler);			
		}

		/**
		 * Set the dependencies
		 * @param dep (Dictionary) Key = Class and Value is the object
		 */
		private var _connectionHandler;
		private var _loginHandler;
		private var _roomHandler;
		public override function set dependencies( dep:Dictionary ):void 
		{ 
			_networkManager = dep[ConnectionHandler];
			_networkManager = dep[ConnectionHandler];
			_networkManager = dep[ConnectionHandler];
		}
		
		/****************************************/
		// Overide function
		/****************************************/
		
		private var _sfs:SmartFox = new SmartFox(true);
		
		/**
		 * Get the smartfox server
		 */
		public function get sfs():SmartFox { return _sfs; }
		
		/**
		 * Get the connection handler
		 */
		public function get connectionHandler():void { return _connectionHandler; }
		
		/**
		 * Get the login handler
		 */
		public function get loginHandler():void { return _loginHandler; }
		
		/**
		 * Get the room handler
		 */
		public function get roomHandler():void { return _roomHandler; }		
		
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
		private function joinRoom(name:String = "The Lobby"):void
		{
			_roomHandler.joinRoom(name);
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
			_roomHandler.joinRoom(roomName, roomPwd, roomMaxS, extensionId, extensionClass);
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom():void
		{
			_roomHandler.leaveGameRoom();
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

